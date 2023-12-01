import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/models/task.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/todo_tile.dart';
import 'package:todo_riverpod/common/widgets/width_spacer.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_notifier.dart';

class CompletedListView extends ConsumerWidget {
  const CompletedListView({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Task> listData = ref.watch(todosNotifierProvider);
    List<String> pastDates =
        ref.read(todosNotifierProvider.notifier).getDatesOneMonthBeforeToday();
    List<Task> completed = listData
        .where((element) =>
            element.isCompleted == 1 ||
            pastDates.contains(element.date!.substring(0, 10)))
        .toList();
    return ListView.builder(
        itemCount: completed.length,
        itemBuilder: (context, index) {
          final data = completed[index];

          dynamic color = ref.read(todosNotifierProvider.notifier).getRandomColor();

          return TodoTile(
            title: data.title,
            color: color,
            start: data.startTime,
            end: data.endTime,
            description: data.desc,
            editIcon: const WidthSpacer(width: 20),
            delete: () =>
                ref.watch(todosNotifierProvider.notifier).deleteTodos(data.id ?? 0),
            child: const Icon(
              AntDesign.checkcircle,
              color: AppConst.kGreen,
            ),
          );
        });
  }
}
