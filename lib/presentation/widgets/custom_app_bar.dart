import 'package:flutter/material.dart';

/// Custom AppBar widget that can be reused across different screens.
/// 
/// This widget takes a [title] and displays it in the AppBar.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  /// Constructor for [CustomAppBar].
  /// 
  /// Requires a [title] to be displayed in the AppBar.
  CustomAppBar({required this.title});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        title,
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      backgroundColor: Colors.blueAccent,
      elevation: 4,
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.blue, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
