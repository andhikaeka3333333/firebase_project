import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utils/theme.dart';
import '../widgets/my_color.dart';
import '../widgets/my_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.backgroundSecondaryColor,
        title: const MyText(
          text: 'Notification',
          fontSize: 20,
          colors: white,
          fontWeight: FontWeight.bold,
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            'assets/images/background.png',
            width: Get.width,
            height: Get.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppTheme.backgroundSecondaryColor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppTheme.backgroundColor,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.asset(
                                'assets/images/berita1.jpeg',
                                width: double.infinity,
                                height: 190,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 20, right: 10, bottom: 23),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                MyText(
                                  text: 'Berita',
                                  fontSize: 14,
                                  colors: white,
                                  fontWeight: FontWeight.w600,
                                ),
                                SizedBox(width: 8),
                                MyText(
                                  text: '• CNN Indonesia',
                                  fontSize: 14,
                                  colors: Colors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ],
                            ),
                            SizedBox(height: 8),
                            MyText(
                              text: 'Rupiah Terangkat ke Rp16.267 Pagi Ini',
                              fontSize: 16,
                              colors: white,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}