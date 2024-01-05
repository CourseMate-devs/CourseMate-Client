import 'dart:developer';

import 'package:course_mate/Model/temp.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

enum SignInType {
  none,
  google,
  apple,
}

SignInType _currentSignInType = SignInType.none;

class SocialLoginService {
  /// Singleton Pattern
  static final SocialLoginService _socialLoginService = SocialLoginService._();
  SocialLoginService._();
  factory SocialLoginService() {
    return _socialLoginService;
  }
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final TempModel tempModel = TempModel();

  // 유저 상태의 변화를 체크한다
  void onCurrentUserChanged(Function(GoogleSignInAccount? account) callback) {
    _googleSignIn.onCurrentUserChanged.listen(callback);
  }

  // 유저 로그인을 유지시켜준다
  void signInSilently() {
    _googleSignIn.signInSilently();
  }

  Future<bool> googleLogin() async {
    try {
      GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if(googleUser == null){
        return false;
      }
      tempModel.setUser(googleUser);
      log('구글 로그인 대성공');

      // 로그인 성공시 Google 인증 토큰 획득
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      // 여기에서 서버로 Google 토큰을 보내서 사용자 인증 받기
      // ~
      // setSocialLoginAccountInfo(googleUser.email, 'GOOGLE');

      return true;
    } catch (error) {
      log('google 로그인 fail: $error');
      return false;
    }
  }
  Future<bool> googleLogout() async {
    try {
      await _googleSignIn.signOut();
      tempModel.setUser(null);
      return true;
    } catch(error) {
      log("Google 로그아웃 실패");
      return false;
    }
  }
  /// Oauth -> 회원가입 과정
  //모델에 구글 로그인을 통해 가져온 email 정보를 넣어준다.
  // void setSocialLoginAccountInfo(String email, String provider) {
  //   basicUser.email = email;
  //   basicUser.oauthProvider = provider;
  // }

}


///class _SignInState{
  //구글 계정 정보 가져온다
  // @override
  // void initState() {
  //   super.initState();
  //   // 구글 account = _currentUser
  //   _googleSignIn.onCurrentUserChanged.listen((GoogleSignInAccount? account) {
  //     setState(() {
  //       _currentUser = account;
  //     });
  //   });
  //   //로그인한 상태 유지.
  //   /*
  //    * 1.저장된 인증 토큰 확인
  //    * 2.유효한 토큰 O => 자동 로그인
  //    * 3.상태 업데이트 (정보 업데이트)
  //    */
  //   _googleSignIn.signInSilently();
  // }
  // Future<void> _handleSignIn() async{
  //   try{
  //     await _googleSignIn.signIn();
  //     setState(() {
  //       _currentSignInType = SignInType.google;
  //     });
  //   } catch(error){
  //     log("error sigining in: $error");
  //   }
  // }
  // Future<void> _handleSignOut() => _googleSignIn.disconnect();

