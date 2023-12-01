import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_riverpod/common/utils/constants.dart';
import 'package:todo_riverpod/common/widgets/bottom_titles.dart';

class XpansionTile extends ConsumerWidget {
  const XpansionTile({
    super.key,
    required this.children,
    required this.text,
    required this.text2,
    this.onExpansionChanged, required this.trailing,
  });

  final List<Widget> children;
  final String text;
  final String text2;
  final void Function(bool)? onExpansionChanged;
  final Widget? trailing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      decoration: const BoxDecoration(
        color: AppConst.kBackgroundLight,
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),

// Applies the given theme [data] to [child].
// The [data] and [child] arguments must not be null.
      child: Theme(
        data: Theme.of(context).copyWith(
          dividerColor: Colors.transparent,
        ),
        child:  ExpansionTile(
              
              title: BottomTitles(text: text, text2: text2,),
              tilePadding: EdgeInsets.zero,
              childrenPadding: EdgeInsets.zero,
              // When the tile starts expanding, this function is called with the value true.
              onExpansionChanged: onExpansionChanged,
              //used to force the expansion arrow icon to the tile's leading or trailing edge.
              controlAffinity: ListTileControlAffinity.trailing,
              trailing: trailing,
              // The widgets that are displayed when the tile expands.
              children: children,
            )
      ),
    );
  }
}
