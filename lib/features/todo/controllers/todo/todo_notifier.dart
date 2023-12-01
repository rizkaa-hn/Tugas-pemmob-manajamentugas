import 'dart:math';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:todo_riverpod/common/helper/db_helper.dart';
import 'package:todo_riverpod/common/models/task.dart';
import 'package:todo_riverpod/common/utils/constants.dart';

part 'todo_notifier.g.dart';


@riverpod
class TodosNotifier extends _$TodosNotifier {
  // We initialize the list of todos to an empty list
  @override
  List<Task> build() {
    return [];
  }

  void refresh() async {
    final data = await DBHelper.getItems();
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
    state = data.map((e) => Task.fromJson(e)).toList();
  }

  Future<void> addItem(Task task) async {
    await DBHelper.createItem(task);
    refresh();
  }

  Future<void> updateTodos(int id, String title, String desc, String date,
      String startTime, String endTime) async {
    await DBHelper.updateItem(id, title, desc, 0, date, startTime, endTime);
    refresh();
  }

  Future<void> deleteTodos(int id) async {
    await DBHelper.deleteItem(id);
    refresh();
  }



  Future<void> markAsCompleted(int id, String title, String desc, String date,
      String startTime, String endTime) async {
    await DBHelper.updateItem(id, title, desc, 1, date, startTime, endTime);
    refresh();
  }

  // random colors from our list
  dynamic getRandomColor() {
    Random random = Random();
    int randomIndex = random.nextInt(colors.length);
    return colors[randomIndex];
  }

// today
  String getToday() {
    DateTime today = DateTime.now();
    return today.toString().substring(0, 10);
  }

// tomorrow
  String getTomorrow() {
    DateTime tomorrow = DateTime.now().add(const Duration(days: 1));
    return tomorrow.toString();
  }

// Day after tomorrow
  String dayAfterTomorrow() {
    DateTime today = DateTime.now().add(const Duration(days: 2));
    return today.toString();
  }

  // last 30 days
  List<String> getDatesOneMonthBeforeToday() {
    DateTime today = DateTime.now();
    DateTime oneMonthAgo = today.subtract(const Duration(days: 30));

    List<String> dates = [];
    for (int i = 0; i < 30; i++) {
      DateTime date = oneMonthAgo.add(Duration(days: i));
      dates.add(date.toString().substring(0, 10));
    }
    return dates;
  }

  bool getStatus(Task data) {
    bool? isCompleted;
    if (data.isCompleted == 0) {
      isCompleted = false;
    } else {
      isCompleted = true;
    }
    return isCompleted;
  }



}
