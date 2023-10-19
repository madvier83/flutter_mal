import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class AppBarGlobal extends StatefulWidget {
  const AppBarGlobal({super.key});

  @override
  State<AppBarGlobal> createState() => _AppBarGlobalState();
}

class _AppBarGlobalState extends State<AppBarGlobal> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
          ),
          Text("MAL Viewer"),
          CircleAvatar(
            backgroundColor: Colors.transparent,
          ),
        ],
      ),
    );
  }
}
