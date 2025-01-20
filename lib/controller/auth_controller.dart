import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/controller/notif_controller.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:get/get.dart';

import '../routes/myapp_route.dart';

class AuthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  StreamSubscription<QuerySnapshot>? subscription;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  var user = Rx<User?>(null);
  Rx<bool> isLoading = Rx<bool>(false);

  @override
  void onInit() {
    super.onInit();
    user.value = _auth.currentUser;
  }

  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        await _auth.signInWithCredential(credential);
        user.value = _auth.currentUser;
        addFcmToken();
        Get.offNamed(MyappRoute.navbar);
      }
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
    isLoading.value = false;
  }

  Future<void> addFcmToken({ String? token }) async {
    if (user.value != null) {
      final NotifController notifController = Get.put(NotifController());
      final FirebaseFirestore firestore = FirebaseFirestore.instance;
      String? fcmToken = token ?? notifController.fcmToken;
      Map<String, dynamic> data = {
        'user': user.value!.uid,
        'createdAt': FieldValue.serverTimestamp(),
      };

      // try create collection on database
      try {
        await firestore.collection('fcm_tokens').doc(fcmToken).set(data);
        print('Success adding fcm token to database.');
      } catch (e) {
        print('Error adding fcm token to database: $e');
      }
    }
  }

  Future<void> logout() async {
    isLoading.value = true;
    try {
      subscription?.cancel();
      await _googleSignIn.signOut();
      await _auth.signOut();
      user.value = null;
      Get.offNamed(MyappRoute.login); // Navigate to LoginPage
    } catch (e) {
      Get.snackbar('Error', e.toString());
    }
    isLoading.value = false;
  }
}
