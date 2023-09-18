import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      title: Container(
        color: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: const Text('Nikos Voice Order', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
      ),
      iconTheme: const IconThemeData(color: Colors.black),
      actions: [IconButton(icon: const Icon(Icons.favorite), onPressed: () {})]
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(50.0);
}