import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/google_auth/google_auth_cubit.dart';
import 'package:flutter_mal/bloc/google_auth/google_auth_state.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/widgets/form/text_field_global.dart';
import 'package:flutter_mal/widgets/typography/heading.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Heading("MAL Viewer"),
              const SizedBox(height: 32),
              TextFieldGlobal(
                controller: emailController,
                hintText: "Email",
                icon: Icons.mail,
                textInputType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextFieldGlobal(
                controller: passwordController,
                hintText: "Password",
                icon: Icons.remove_red_eye,
                obscureText: true,
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () async {
                  try {
                    await login(
                      email: emailController.text,
                      password: passwordController.text,
                    );
                  } catch (e) {
                    print("Failed");
                  }
                },
                child: const Text("Sign In"),
              ),
              const Divider(),
              BlocConsumer<GoogleAuthCubit, GoogleAuthState>(
                listener: (context, state) {
                  if (state is GoogleAuthSuccessState) {
                    Navigator.of(context)
                        .pushReplacementNamed(DefinedRoute().home);
                  }
                },
                builder: (context, state) {
                  return FilledButton(
                    onPressed: state is GoogleAuthLoadingState
                        ? null
                        : () => context.read<GoogleAuthCubit>().signIn(),
                    child: const Text("Sign In With Google"),
                  );
                },
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    child: const Text("Sign Up"),
                    onPressed: () {
                      // REDIRECT HOME
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        DefinedRoute().register,
                        (route) => false,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      // REDIRECT HOME
      Navigator.of(context).pushNamedAndRemoveUntil(
        DefinedRoute().home,
        (route) => false,
      );
    } on FirebaseAuthException {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          backgroundColor: Colors.red,
          content: Text(
            'Wrong email or password.',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );
      // if (e.code == 'user-not-found') {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('No user found for that email.')));
      // } else if (e.code == 'wrong-password') {
      //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //       content: Text('Wrong password provided for that user.')));
      // }
    }
  }
}
