import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../widgets/button_widget.dart';
import 'theme.dart';

class ModalUtils {

  static Future loginError(BuildContext context, Exception e, Function onRetry) {
    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.backgroundSecondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 32.0,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/icons/drag.png', height: 8),
                    const SizedBox(height: 20),
                    Text(
                      'Oops.. Ada masalah!',
                      style: AppTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi kesalahan ketika mencoba membuatmu login. Silahkan coba lagi.',
                      style:
                          AppTheme.textTheme.labelMedium.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      e.toString(),
                      style: AppTheme.textTheme.labelSmall
                          .copyWith(color: AppTheme.white60),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget('Coba lagi', variant: ButtonVariant.primary,
                        onPressed: () {
                      onRetry();
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ));
  }

  static Future dataError(
      BuildContext context, String action, Exception e) {
    return showMaterialModalBottomSheet(
        context: context,
        backgroundColor: AppTheme.backgroundSecondaryColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        builder: (context) => SingleChildScrollView(
              controller: ModalScrollController.of(context),
              child: Padding(
                padding: const EdgeInsets.only(
                  top: 20.0,
                  left: 20.0,
                  right: 20.0,
                  bottom: 32.0,
                ),
                child: Column(
                  children: [
                    Image.asset('assets/icons/drag.png', height: 8),
                    const SizedBox(height: 20),
                    Text(
                      'Oops.. Ada masalah!',
                      style: AppTheme.textTheme.titleSmall,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Terjadi kesalahan ketika $action data, namun data akan disinkronkan kembali setelah tersambung kembali.',
                      style:
                          AppTheme.textTheme.labelMedium.copyWith(fontSize: 16),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      e.toString(),
                      style: AppTheme.textTheme.labelSmall
                          .copyWith(color: AppTheme.white60),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    ButtonWidget('Oke mengerti', variant: ButtonVariant.primary,
                        onPressed: () {
                      Navigator.pop(context);
                    }),
                  ],
                ),
              ),
            ));
  }
}
