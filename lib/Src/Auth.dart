import 'package:flutter/material.dart';
import 'package:flutterfirebase_season7/Src/LoginWidget.dart';
import 'package:flutterfirebase_season7/Src/SignUpWidget.dart';

class Auth extends StatefulWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  State<Auth> createState() => _AuthState();
}

class _AuthState extends State<Auth> {
  bool isLogin = true;

  @override
  Widget build(BuildContext context)=>isLogin
      ? LoginWidget(onClickedSignUp: toggle,)
      : SignUpWidget(onClickedSignUp: toggle,);
    void toggle()=>setState(()=>isLogin=!isLogin);
}
