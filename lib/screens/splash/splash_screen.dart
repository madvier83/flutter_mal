import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/widgets/typography/heading.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  bool _mounted = false;

  @override
  void initState() {
    super.initState();
    _mounted = true;
    final user = FirebaseAuth.instance.currentUser;
    if (_mounted) {
      Future.delayed(const Duration(seconds: 2), () {
        if (user != null) {
          // User is logged in, navigate to the home screen
          Navigator.of(context).pushReplacementNamed(DefinedRoute().home);
        } else {
          // User is not logged in, navigate to the login screen
          Navigator.of(context).pushReplacementNamed(DefinedRoute().login);
        }
      });
    }
  }

  @override
  void dispose() {
    _mounted = false;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "MAL",
              style: TextStyle(
                  fontSize: 42,
                  color: Color(0xff2E51A2),
                  fontWeight: FontWeight.bold),
            ),
            Heading("Viewer"),
          ],
        ),
      ),
    );
  }
}
