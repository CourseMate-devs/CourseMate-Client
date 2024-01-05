import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

class SocialLoginService {
  //_()은 private 생성자
  // 싱글톤 패턴
  static final SocialLoginService _socialLoginService = SocialLoginService._();
  SocialLoginService._();
  factory SocialLoginService() {
    return _socialLoginService;
  }

  Future<bool> kakaoLogin() async {
// 카카오톡 설치 여부 확인
// 카카오톡이 설치되어 있으면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
    if (await isKakaoTalkInstalled()) {
      try {
        print("카카오톡 앱 로그인 시도");
        await UserApi.instance.loginWithKakaoTalk();
        print('카카오톡으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오톡으로 로그인 실패 $error');

        // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
        // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
        if (error is PlatformException && error.code == 'CANCELED') {
          return false;
        }
        // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
        try {
          print('카카오톡에 연결된 앱이 없을 경우');
          await UserApi.instance.loginWithKakaoAccount();
          User user = await UserApi.instance.me();
          print(user.kakaoAccount);
          print('카카오계정으로 로그인 성공');
          return true;
        } catch (error) {
          print('카카오계정으로 로그인 실패 $error');
          return false;
        }
      }
    } else {
      try {
        print('카카오 계정으로 로그인 시도');
        // print(await KakaoSdk.origin);
        await UserApi.instance.loginWithKakaoAccount();
        print('카카오계정으로 로그인 성공');
        return true;
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
        return false;
      }
    }
  }
}
