import 'package:flutter/material.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';


showLoadingDialog({
  required BuildContext context,
  required String message,
}) async {
  return await showDialog(
    context: context,
    barrierDismissible: false,
    builder: (context) {
      return AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const CircularProgressIndicator(
                  color: AppConst.kGreen,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Text(
                    message,
                    style: appstyle(18, AppConst.kLightGrey, FontWeight.w600),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}
