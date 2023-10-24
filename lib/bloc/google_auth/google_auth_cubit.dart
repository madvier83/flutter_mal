import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_mal/bloc/google_auth/google_auth_state.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthCubit extends Cubit<GoogleAuthState> {
  GoogleAuthCubit() : super(GoogleAuthInitialState());

  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final _auth = FirebaseAuth.instance;

  void signIn() async {
    try {
      emit(GoogleAuthLoadingState());

      final account = await _googleSignIn.signIn();
      if (account == null) {
        emit(GoogleAuthFailedState(error: "Cancel"));
        return;
      }
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
      final userCredential = await _auth.signInWithCredential(credential);

      emit(GoogleAuthSuccessState(user: userCredential.user!));
    } catch (e) {
      emit(GoogleAuthFailedState(error: "$e"));
    }
  }
}
