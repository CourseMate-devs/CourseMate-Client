import 'package:google_sign_in/google_sign_in.dart';

class TempModel{
  GoogleSignInAccount? currentUser;

  void setUser(GoogleSignInAccount? currentUser){
    this.currentUser = currentUser;
  }
}