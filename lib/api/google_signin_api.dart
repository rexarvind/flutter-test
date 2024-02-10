import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
    // clientId: '1053702216845-s4vcgjlhkddp057lgfvlcd8j65b55rsf.apps.googleusercontent.com'
    clientId: '1053702216845-v37rsfg9039o3kv56puheq646eqravef.apps.googleusercontent.com'
  );
  static Future<GoogleSignInAccount?> login()=> _googleSignIn.signIn();
}