import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_supabase_google_auth/api/auth/google_sign_in_service.dart';
import 'package:flutter_supabase_google_auth/model/user_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart' hide User;

final authStateProvider = StreamProvider<AuthState>((ref) {
  return Supabase.instance.client.auth.onAuthStateChange;
});

final authProvider = StateNotifierProvider<AuthNotifier, UserModel?>((ref) {
  final authStream = ref.watch(authStateProvider);
  return AuthNotifier(authStream);
});

class AuthNotifier extends StateNotifier<UserModel?> {
  AuthNotifier(AsyncValue<AuthState> authState) : super(null) {
    authState.whenData((data) {
      _handleAuthStateChange(data.event, data.session);
    });
  }

  void _handleAuthStateChange(AuthChangeEvent event, Session? session) {
    if (session != null) {
      final user = session.user;
      state = UserModel(
        uid: user.id,
        displayName: user.userMetadata?['full_name'],
        email: user.email,
        photoUrl: user.userMetadata?['avatar_url'],
      );
    } else {
      
      state = null;
    }
  }

  Future<void> signInWithGoogle() async {
    await GoogleSignInService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await GoogleSignInService.signOut();
  }
}