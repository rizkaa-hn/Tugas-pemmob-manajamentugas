import 'package:flutter/material.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';

showAlertDialog({
  required BuildContext context,
  required String message,
  String? btnText,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text(
          message,
          style: appstyle(18, AppConst.kLight, FontWeight.w600),
        ),
        contentPadding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              btnText ?? "OK",
              style: appstyle(18, AppConst.kGreyDark, FontWeight.w600),
            ),
          ),
        ],
      );
    },
  );
}
