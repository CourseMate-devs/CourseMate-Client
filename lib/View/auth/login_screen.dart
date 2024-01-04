import 'package:course_mate/Presenter/auth/social_login_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      body: renderBody(),
    );
  }

  Widget renderBody() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: SingleChildScrollView(
        child: SafeArea(
          child: Stack(children: [
            Container(
              padding:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 3),
              child: Center(
                child: renderLoginButton(),
              ),
            )
          ]),
        ),
      ),
    );
  }

  Widget renderLoginButton() {
    return ElevatedButton(
      onPressed: didTapKakaoLoginButton,
      style: ElevatedButton.styleFrom(
          backgroundColor: Colors.amber,
          elevation: 0,
          fixedSize: Size(MediaQuery.of(context).size.width, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          )),
      child: const Text(
        '로그인',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  Future<void> didTapKakaoLoginButton() async {
    if (await SocialLoginService().kakaoLogin()) {
      print("로그인 성공");
    } else {
      print("로그인 실패");
    }
  }
}
