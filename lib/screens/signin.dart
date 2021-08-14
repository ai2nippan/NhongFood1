import 'dart:convert';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongfood1/model/user_model.dart';
import 'package:nhongfood1/screens/main_rider.dart';
import 'package:nhongfood1/screens/main_shop.dart';
import 'package:nhongfood1/screens/main_user.dart';
import 'package:nhongfood1/utility/my_style.dart';
import 'package:nhongfood1/utility/normal_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  // Field
  String? user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: RadialGradient(
          colors: <Color>[Colors.white, MyStyle().primaryColor],
          center: Alignment(0, -0.3),
          radius: 1.0,
        )),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                MyStyle().showLogo(),
                MyStyle().mySizebox(),
                MyStyle().showTitle('Nhong Food'),
                MyStyle().mySizebox(),
                userForm(),
                MyStyle().mySizebox(),
                passwordForm(),
                MyStyle().mySizebox(),
                loginButton()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget loginButton() => Container(
        width: 250.0,
        child: ElevatedButton(
          style: MyStyle().myButtonStyle(),
          onPressed: () {
            if ((user?.isEmpty ?? true) || (password?.isEmpty ?? true)) {
              normalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบ คะ');
            } else {
              checkAuthen();
            }
          },
          child: Text(
            'Register',
            style: TextStyle(color: Colors.white),
          ),
        ),
      );



  // Widget loginButton() {
  //   return Container(
  //     width: 250.0,
  //     child: ElevatedButton(
  //       style: MyStyle().myButtonStyle(),
  //       onPressed: () {
  //         if ((user?.isEmpty??true) || (password?.isEmpty??true)) {
  //           normalDialog(context, 'มีช่องว่าง กรุณากรอกให้ครบ คะ');
  //         } else {
  //         }
  //       },
  //       child: Text(
  //         'Login',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Future<Null> checkAuthen()async{
    String url = 'http://172.20.10.3/Mobile/Flutter2/Train/testapp_food1/php/getUserWhereUser.php?isAdd=true&user=$user';

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      var result = json.decode(response.data);
      print('result = $result');
      for (var map in result) {
        UserModel userModel = UserModel.fromJson(map);
        if (password == userModel.password) {
          String chooseType = userModel.choosetype.toString();
          if (chooseType == 'User') {
            routeToService(MainUser(),userModel);
          } else if (chooseType == 'Shop') {
            routeToService(MainShop(),userModel);
          } else if (chooseType == 'Rider') {
            routeToService(MainRider(),userModel);
          } else {
            normalDialog(context, 'Error');
          }
        } else {
          normalDialog(context, 'Password ผิด กรุณาลองใหม่ ');
        }
      }

    } catch (e) {
    }

  }

  Future<Null> routeToService(Widget myWidget, UserModel userModel) async{

    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString('id', userModel.id.toString());
    preferences.setString('choosetype', userModel.choosetype.toString());
    preferences.setString('name', userModel.name.toString());

    MaterialPageRoute route = MaterialPageRoute(builder: (context) => myWidget,);
    Navigator.pushAndRemoveUntil(context, route, (route) => false);
  }


  Widget userForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => user = value.trim(),
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.account_box,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'User :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );

  Widget passwordForm() => Container(
        width: 250.0,
        child: TextField(
          onChanged: (value) => password = value.trim(),
          obscureText: true,
          decoration: InputDecoration(
            prefixIcon: Icon(
              Icons.lock,
              color: MyStyle().darkColor,
            ),
            labelStyle: TextStyle(color: MyStyle().darkColor),
            labelText: 'Password :',
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().darkColor)),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: MyStyle().primaryColor)),
          ),
        ),
      );
}
