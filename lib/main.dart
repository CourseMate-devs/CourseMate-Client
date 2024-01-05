import 'package:course_mate/View/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // 비동기를 위해 작성
  await dotenv.load(fileName: ".env"); // 환경변수
  await _initialize();
  runApp(const MyApp());
}

Future<void> _initialize() async {
  KakaoSdk.init(
    nativeAppKey: dotenv.get("KAKAO_NATIVE_KEY"),
    javaScriptAppKey: dotenv.get("JAVASCRIPT_APP_KEY"),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false, // 시뮬레이터 오른쪽 상단에 'debug' 배너 삭제
      home: Scaffold(
        backgroundColor: Colors.purple,
        body: LoginScreen(),
      ),
    );
  }
}
