import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar;
  final EdgeInsets padding;
  const CustomAppBar({Key? key, required this.appBar, required this.padding}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(56.0);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Center(
        child: appBar,
      ),
    );
  }
}
