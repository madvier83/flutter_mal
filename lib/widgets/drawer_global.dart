import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:google_sign_in/google_sign_in.dart';

class DrawerGlobal extends StatefulWidget {
  const DrawerGlobal({super.key});

  @override
  State<DrawerGlobal> createState() => _DrawerGlobalState();
}

class _DrawerGlobalState extends State<DrawerGlobal> {
  User? user = FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                ListTile(
                  leading: CircleAvatar(
                    radius: 18,
                    backgroundImage: NetworkImage(
                      user?.photoURL ??
                          "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png",
                    ),
                  ),
                  title: Text(user!.displayName ?? "Welcome Back"),
                  subtitle: Text(user!.email ?? "user@gmail.com"),
                )
              ],
            ),
            Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: FilledButton.tonal(
                          onPressed: () async {
                            await signOut();
                          },
                          child: const Text("Sign Out"),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Future<void> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      await GoogleSignIn().signOut();
      // REDIRECT LOGIN
      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          DefinedRoute().login,
          (route) => false,
        );
      }
    } catch (e) {
      // print("Error signing out: $e");
    }
  }
}
