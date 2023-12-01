import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/helper/notificaions_helper.dart';
import 'package:todo_riverpod/common/models/task.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/app_style.dart';
import 'package:todo_riverpod/common/widgets/custom_outline_btn.dart';
import 'package:todo_riverpod/common/widgets/custom_textfield.dart';
import 'package:todo_riverpod/common/widgets/height_spacer.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart'
    as picker;
import 'package:todo_riverpod/common/widgets/show_alert_dialog.dart';
import 'package:todo_riverpod/features/todo/controllers/start_time_provider.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_notifier.dart';
import 'package:todo_riverpod/features/todo/pages/homepage.dart';

class AddTask extends ConsumerStatefulWidget {
  const AddTask({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddTaskState();
}

class _AddTaskState extends ConsumerState<AddTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController desc = TextEditingController();

  late NotificaticationsHelper controller;
  late var notifyHelper;

  List<int> notifications = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0), () {
      controller = NotificaticationsHelper(ref: ref);
    });
    notifyHelper = NotificaticationsHelper(ref: ref);
    notifyHelper.initializeNotification();
    notifyHelper.requestIOSPermissions();
  }

  @override
  Widget build(BuildContext context) {
    var start = ref.watch(startTimeNotifierProvider);
    var finish = ref.watch(finishTimeNotifierProvider);
    var scheduleDate = ref.watch(dateNotifierProvider);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0.w),
        child: ListView(
          children: [
            const HeightSpacer(size: 20),
            CustomTextField(
                hintText: "Add title",
                controller: title,
                hintStyle: appstyle(16, AppConst.kLightGrey, FontWeight.w600)),
            const HeightSpacer(size: 20),

            CustomTextField(
                hintText: "Add description",
                controller: desc,
                hintStyle: appstyle(16, AppConst.kLightGrey, FontWeight.w600)),
            const HeightSpacer(size: 20),

            // DATE PICKER
            Consumer(
              builder: (context, ref, child) {
                return CustomOutlineBtn(
                    onTap: () {
                      picker.DatePicker.showDatePicker(context,
                          showTitleActions: true,
                          minTime: DateTime(2023, 5, 5),
                          maxTime: DateTime(2024, 6, 7),
                          theme: const picker.DatePickerTheme(
                              doneStyle: TextStyle(
                                  color: AppConst.kGreen,
                                  fontSize: 16)), onConfirm: (date) {
                        ref
                            .read(dateNotifierProvider.notifier)
                            .setStartDate(date);
                        ref
                            .read(dateNotifierProvider.notifier)
                            .setStart(date.toString());
                      },
                          currentTime: DateTime.now(),
                          locale: picker.LocaleType.en);
                    },
                    hieght: 52.h,
                    text: scheduleDate == ""
                        ? "Set date"
                        : scheduleDate.substring(0, 10),
                    color2: AppConst.kLightGrey,
                    color: AppConst.kLight);
              },
            ),

            const HeightSpacer(size: 20),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomOutlineBtn(
                    onTap: () {
                      // print(ref.watch(notificationDateNotifierProvider.notifier).startTime);
                      picker.DatePicker.showDateTimePicker(context,
                          locale: LocaleType.en,
                          showTitleActions: true, onConfirm: (date) {
                        
                        notifications = ref
                            .read(startTimeNotifierProvider.notifier)
                            .dates(date);
                        ref
                            .read(startTimeNotifierProvider.notifier)
                            .setStart(date.toString());
                      },
                          currentTime:
                              ref.watch(notificationDateNotifierProvider));
                    },
                    hieght: 52.h,
                    width: AppConst.kWidth * .4,
                    text: start == "" ? "Start Time" : start.substring(10, 16),
                    color2: AppConst.kLightGrey,
                    color: AppConst.kLight),
                CustomOutlineBtn(
                    onTap: () {
                      picker.DatePicker.showDateTimePicker(context,
                          locale: LocaleType.en,
                          showTitleActions: true, onConfirm: (date) {
                        ref
                            .read(finishTimeNotifierProvider.notifier)
                            .setStart(date.toString());
                      }, currentTime:
                              ref.watch(notificationDateNotifierProvider));
                    },
                    hieght: 52.h,
                    width: AppConst.kWidth * .4,
                    color2: AppConst.kGreyDark,
                    text: finish == "" ? "End Time" : finish.substring(10, 16),
                    color: AppConst.kLight),
              ],
            ),
            const HeightSpacer(size: 20),
            Consumer(
              builder: (context, ref, child) {
                return CustomOutlineBtn(
                    onTap: () {
                      if (title.text.isNotEmpty &&
                          desc.text.isNotEmpty &&
                          scheduleDate.isNotEmpty &&
                          start.isNotEmpty &&
                          finish.isNotEmpty) {
                        Task task = Task(
                          title: title.text,
                          desc: desc.text,
                          isCompleted: 0,
                          date: scheduleDate,
                          startTime: start.substring(10, 16),
                          endTime: finish.substring(10, 16),
                          remind: 0,
                          repeat: "yes",
                        );
                        notifyHelper.scheduledNotification(
                            notifications[0],
                            notifications[1],
                            notifications[2],
                            notifications[3],
                            task);
                        ref
                            .read(todosNotifierProvider.notifier)
                            .addItem(task)
                            .then((value) {
                          ref.read(dateNotifierProvider.notifier).setStart('');
                          ref
                              .read(startTimeNotifierProvider.notifier)
                              .setStart('');
                          ref
                              .read(finishTimeNotifierProvider.notifier)
                              .setStart('');
                        });

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const HomePage()));
                      } else {
                        showAlertDialog(
                            context: context,
                            message: "To submit please provide all fields");
                      }
                    },
                    hieght: 52.h,
                    text: "Submit",
                    color2: AppConst.kGreen,
                    color: AppConst.kLight);
              },
            )
          ],
        ),
      ),
    );
  }
}
