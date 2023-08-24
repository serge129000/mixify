/* import 'package:extension_google_sign_in_as_googleapis_auth/extension_google_sign_in_as_googleapis_auth.dart';
import 'package:google_sign_in/google_sign_in.dart'; */
import 'package:googleapis/youtube/v3.dart';
import 'package:googleapis_auth/auth_io.dart';

class GoogleAuthCredentials {
  //static const apiKey = 'AIzaSyBfS3JVYcglCiWdP_xBmDClOANhXdvCtT0';
  static const apiKey = 'AIzaSyCrXJm5W5sZ4Bzq87Vx7N9A9OymH8ZCE7w';
  /* final googleSignIn = GoogleSignIn(
      scopes: <String>[YouTubeApi.youtubeReadonlyScope],
    ); */
  static final client = clientViaApiKey(apiKey);
  static var httpClient = (client);
  static YouTubeApi youTubeApi = YouTubeApi(httpClient);
}
