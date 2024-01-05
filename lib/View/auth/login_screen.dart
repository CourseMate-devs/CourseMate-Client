
import 'package:course_mate/Model/temp.dart';
import 'package:course_mate/Presenter/auth/google_oauth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final SocialLoginService _socialLoginService = SocialLoginService();

  @override
  void initState(){
    super.initState();
    _socialLoginService.onCurrentUserChanged((GoogleSignInAccount? account){
      setState(() {
        if(account != null) {
          _socialLoginService.tempModel.setUser(account);
        }else{

        }
      });
    });
    _socialLoginService.signInSilently();
  }

  Widget _buildBody(){
    //_socialLoginService.googleLogout();
    GoogleSignInAccount? user = _socialLoginService.tempModel.currentUser;
    if( user != null){
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          ListTile(
            leading: GoogleUserCircleAvatar(identity: user),
            title: Text(user.displayName ?? 'No Name'),
            subtitle: Text(user.email),
          ),
          ElevatedButton(onPressed: () async{
            await _socialLoginService.googleLogout();

            }, child: const Text("sign out")
          ),
        ],
      );
    } else{
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          const Text('현재 로그인이 되어 있지 않습니다'),
          ElevatedButton(onPressed: () async{
            await _socialLoginService.googleLogin();

          }, child: const Text('sign in with google'))
        ],
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('google sign in'),
      ),
      body: ConstrainedBox(
        constraints: const BoxConstraints.expand(),
        child: _buildBody(),
      )
    );
  }
}
