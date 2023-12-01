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

class TomorrowList extends ConsumerWidget {
  const TomorrowList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosNotifierProvider);
    String tomorrow = ref
        .read(todosNotifierProvider.notifier)
        .getTomorrow()
        .toString()
        .substring(0, 10);
    var tommorrowTodos =
        todos.where((element) => element.date!.contains(tomorrow));
    dynamic color = ref.read(todosNotifierProvider.notifier).getRandomColor();
    return XpansionTile(
      text: "Besok",
      text2: "Yang perlu kamu lakukan besok",
      onExpansionChanged: (bool expanded) {
        ref.read(xpansionStateProvider.notifier).changeState(expanded);
      },
      trailing: Padding(
        padding: EdgeInsets.only(right: 12.0.w),
        child: ref.watch(xpansionStateProvider)
            ? const Icon(AntDesign.closecircleo)
            : const Icon(AntDesign.circledown),
      ),
      children: [
        for (final todo in tommorrowTodos)
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
