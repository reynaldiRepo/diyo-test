import 'package:diyo/util/theme_color.dart';
import 'package:flutter/material.dart';

class DiyoAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final Widget? leading;
  final List<Widget> actions;

  const DiyoAppBar(
      {super.key, this.title, this.leading, this.actions = const []});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: leading,
      backgroundColor: DiyoTheme.diyotheme,
      automaticallyImplyLeading: false,
      title: title != null
          ? Text(
              title!,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/image/logo-header.png',
                  fit: BoxFit.contain,
                  height: 22,
                ),
              ],
            ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
