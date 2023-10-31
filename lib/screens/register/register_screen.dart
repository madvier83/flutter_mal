import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mal/constants/route.dart';
import 'package:flutter_mal/widgets/form/custom_snackbar.dart';
import 'package:flutter_mal/widgets/form/text_field_global.dart';
import 'package:flutter_mal/widgets/typography/heading.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Heading("Register"),
              const SizedBox(
                height: 32,
              ),
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
              TextFieldGlobal(
                controller: confirmPasswordController,
                hintText: "Confirm Password",
                icon: Icons.remove_red_eye,
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Expanded(
                    child: FilledButton(
                      onPressed: () async {
                        try {
                          await register(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                        } catch (e) {
                          // print("Failed");
                        }
                      },
                      child: const Text("Create Account"),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Already have an account?"),
                  TextButton(
                    child: const Text("Sign In"),
                    onPressed: () {
                      // REDIRECT HOME
                      Navigator.of(context).pushNamedAndRemoveUntil(
                        DefinedRoute().login,
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

  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      if (email.isEmpty) {
        CustomSnackbar().showCustomSnackbar(context, "Email required.");
        return;
      }
      if (password.isEmpty) {
        CustomSnackbar().showCustomSnackbar(context, "Password required.");
        return;
      }
      if (passwordController.text != confirmPasswordController.text) {
        CustomSnackbar().showCustomSnackbar(context, "Password doesn't match");
        return;
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // REDIRECT LOGIN

      if (mounted) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          DefinedRoute().login,
          (route) => false,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage = "Error";
      if (e.code == 'weak-password') {
        errorMessage = 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage = 'The account already exists for that email.';
      }

      if (mounted) {
        CustomSnackbar().showCustomSnackbar(context, errorMessage);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackbar().showCustomSnackbar(context, "Error");
      }
    }
  }
}
