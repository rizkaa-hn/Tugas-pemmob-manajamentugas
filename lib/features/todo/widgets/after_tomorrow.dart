import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/todo_tile.dart';
import 'package:todo_riverpod/common/widgets/xpansiontile.dart';
import 'package:todo_riverpod/features/todo/controllers/todo/todo_notifier.dart';
import 'package:todo_riverpod/features/todo/controllers/xpansion_provider.dart';
import 'package:todo_riverpod/features/todo/pages/update.dart';

class DayAferTomorrow extends ConsumerWidget {
  const DayAferTomorrow({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosNotifierProvider);

    String dayAfterTomorrow = ref
        .read(todosNotifierProvider.notifier)
        .dayAfterTomorrow()
        .toString()
        .substring(0, 10);

    var dayAftaTodos =
        todos.where((element) => element.date!.contains(dayAfterTomorrow));
    dynamic color = ref.read(todosNotifierProvider.notifier).getRandomColor();
    return XpansionTile(
      text: "${dayAfterTomorrow.substring(5, 10)}  Tasks",
      text2: "Yang masih lama",
      onExpansionChanged: (bool expanded) {
        ref.read(xpansionState0Provider.notifier).changeState(expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.0.w),
        child: ref.watch(xpansionState0Provider)
            ? const Icon(AntDesign.closecircleo)
            : const Icon(AntDesign.circledown),
      ),
      children: [
        for (final todo in dayAftaTodos)
          TodoTile(
              title: todo.title,
              description: todo.desc,
              color: color,
              start: todo.startTime,
              end: todo.endTime,
              editIcon: GestureDetector(
                  onTap: () {
                    updateDescription = todo.desc.toString();
                    updateTitle = todo.title.toString();
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Update(
                                  data: todo,
                                )));
                  },
                  child:
                      const Icon(MaterialCommunityIcons.circle_edit_outline)),
              delete: () =>
                  ref.watch(todosNotifierProvider.notifier).deleteTodos(todo.id ?? 0),
              child: const SizedBox.shrink())
      ],
    );
  }
}
