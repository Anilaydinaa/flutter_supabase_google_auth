import 'dart:developer';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class GoogleSignInService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;

  static Future<AuthResponse?> signInWithGoogle() async {
    try {
      log('Initializing GoogleSignIn...');
      await _googleSignIn.initialize(
        serverClientId:
            "571203712408-dklmf8kb0nvnngth3n8nfj2u3s4qujvn.apps.googleusercontent.com",
      );

      log('Calling authenticate()...');
      final GoogleSignInAccount account = await _googleSignIn.authenticate(
        scopeHint: ['email', 'profile'],
      );
      log('Account: $account');

      final GoogleSignInAuthentication googleAuth = account.authentication;
      final String? idToken = googleAuth.idToken;

      log('Authentication: idToken=${googleAuth.idToken}');
      final AuthResponse response = await supabase.auth.signInWithIdToken(
        provider: OAuthProvider.google,
        idToken: idToken!,
      );

      if (response.user != null) {
        // Optionally insert or update user data in Supabase
        // await _insertUserToSupabase(response.user!);
      }

      return response;
    } catch (e, st) {
      log('Google Sign-In error: $e\n$st');
      return null;
    }
  }

  static Future<void> signOut() async {
    await supabase.auth.signOut();
    await _googleSignIn.signOut();
    log('User signed out from both Supabase and Google.');
  }

  static User? getCurrentUser() => supabase.auth.currentUser;

  /*
  In order to use the _insertUserToSupabase function, you need to create a users table in Supabase. This table will be used to store or update the data of users who sign in with Google.

Creating the users Table
You can create a new table in your Supabase dashboard by following these steps:

In the Supabase dashboard, click the Table Editor icon (the spreadsheet view) on the left-hand menu.

Click the Create a new table button.

Name your table users.

Add the following columns to the table, using the schema shown in the image:

id: Set the type to uuid. This column must be marked as Primary and NOT Nullable to ensure each user has a unique identifier linked to auth.users.

firebase_uid: Set the type to text. This column is optional but can be useful if you're migrating from Firebase or using another authentication system.

email: Set the type to text.

display_name: Set the type to text.

photo_url: Set the type to text.

created_at: Set the type to timestamp and its Default Value to now(). This will automatically record the date and time the user was created.
*/
  static Future<void> _insertUserToSupabase(User user) async {
    try {
      log('Inserting/updating user data in Supabase...');
      await supabase.from('users').upsert({
        'id': user.id,
        'email': user.email,
        'display_name': user.userMetadata?['full_name'],
        'photo_url': user.userMetadata?['avatar_url'],
      });

      log('User inserted/updated successfully in Supabase.');
    } catch (e) {
      log('Supabase user insert error: $e');
    }
  }
}
