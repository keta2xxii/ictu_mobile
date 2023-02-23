import '../app/app_styles.dart';
import 'package:flutter/material.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({
    Key? key,
    this.actions,
    this.backgroundColor,
    this.backButton = false,
    this.onBack,
    required this.colorTitle,
    required this.title,
  }) : super(key: key);

  final List<Widget>? actions;
  final String title;
  final bool backButton;
  final Color colorTitle;
  final Color? backgroundColor;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      leading: backButton
          ? IconButton(
              icon: Icon(Icons.arrow_back_ios, color: colorTitle),
              onPressed: onBack ?? () => Navigator.of(context).pop(),
            )
          : const SizedBox(),
      title: Text(title, style: AppTextStyle().header),
      titleSpacing: 0.0,
      centerTitle: true,
      backgroundColor: backgroundColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarFlexible extends StatelessWidget implements PreferredSizeWidget {
  const AppBarFlexible({
    Key? key,
    this.actions,
    required this.flexible,
    this.hasBackButton = true,
  }) : super(key: key);

  final List<Widget>? actions;
  final Widget flexible;
  final bool hasBackButton;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: hasBackButton
          ? Align(
              alignment: Alignment.bottomLeft,
              child: IconButton(
                  alignment: Alignment.centerLeft,
                  icon: const Icon(
                    Icons.keyboard_arrow_left,
                    size: 32,
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            )
          : const SizedBox(),
      actions: actions,
      flexibleSpace: Align(
        alignment: Alignment.bottomCenter,
        child: flexible,
      ),
      titleSpacing: 0.0,
      centerTitle: true,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class AppBarTransparent extends StatelessWidget implements PreferredSizeWidget {
  const AppBarTransparent({
    Key? key,
    this.actions,
  }) : super(key: key);

  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      actions: actions,
      elevation: 0,
      backgroundColor: Colors.transparent,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
