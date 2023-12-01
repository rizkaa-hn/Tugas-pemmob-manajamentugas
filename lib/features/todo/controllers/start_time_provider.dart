import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'start_time_provider.g.dart';

@riverpod
class StartTimeNotifier extends _$StartTimeNotifier {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }

  List<int> dates(DateTime startDate) {
    DateTime now = DateTime.now();

    Duration difference = startDate.difference(now);

    int days = difference.inDays;
    int hours = difference.inHours % 24;
    int minutes = difference.inMinutes % 60;
    int seconds = difference.inSeconds % 60;

    return [days, hours, minutes, seconds];
  }
}

@riverpod
class FinishTimeNotifier extends _$FinishTimeNotifier {
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }
}

@riverpod
class DateNotifier extends _$DateNotifier {
  DateTime startTime = DateTime.now();
  @override
  String build() {
    return "";
  }

  void setStart(String newState) {
    state = newState;
  }

  void setStartDate(DateTime newState) {
    startTime = newState;
  }
}

@riverpod
class NotificationDateNotifier extends _$NotificationDateNotifier {
  @override
  DateTime build() {
    return ref.read(dateNotifierProvider.notifier).startTime;
  }
}
