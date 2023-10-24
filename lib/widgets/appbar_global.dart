import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AppBarGlobal extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  AppBarGlobal({super.key});
  final User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: const Text("MAL Viewer"),
      leading: IconButton(
        icon: const Icon(Icons.menu),
        onPressed: () => Scaffold.of(context).openDrawer(),
      ),
      actions: [
        CircleAvatar(
          radius: 16,
          backgroundImage: NetworkImage(
            user?.photoURL ??
                "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
