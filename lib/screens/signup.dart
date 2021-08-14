import 'dart:ui';

//import 'package:dio/dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:nhongfood1/utility/my_constant.dart';
import 'package:nhongfood1/utility/my_style.dart';
import 'package:nhongfood1/utility/normal_dialog.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  String? chooseType, name, user, password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: ListView(
        padding: EdgeInsets.all(30.0),
        children: [
          myLogo(),
          MyStyle().mySizebox(),
          showAppName(),
          MyStyle().mySizebox(),
          nameForm(),
          MyStyle().mySizebox(),
          userForm(),
          MyStyle().mySizebox(),
          passwordForm(),
          MyStyle().mySizebox(),
          MyStyle().showTitleH2('ชนิดของสมาชิก :'),
          MyStyle().mySizebox(),
          userRadio(),
          shopRadio(),
          riderRadio(),
          MyStyle().mySizebox(),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() => Container(
        width: 250.0,child: ElevatedButton(
        style: MyStyle().myButtonStyle(),
        onPressed: () {
          print(
              'name = $name, user = $user, password = $password, chooseType = $chooseType');
          //if (name == null || name.isEmpty) {
          //if (name?.isEmpty??true) {

          // OLD TYPE
          //if (name == null || name.isEmpty ||
          //    user == null || user.isEmpty ||
          //    password == null || password.isEmpty ||) {

          // New Type
          if ((name?.isEmpty ?? true) ||
              (user?.isEmpty ?? true) ||
              (password?.isEmpty ?? true)) {
            print('Have Space');
            normalDialog(context, 'มีช่องว่าง คะ กรุณากรอกทุกช่อง คะ');
          } else if (chooseType == null) {
            normalDialog(context, 'โปรด เลือกชนิดของผู้สมัคร');
          } else {
            //registerThread();
            checkUser();
          }
        },
        child: Text(
          'Register',
          style: TextStyle(color: Colors.white),
        ),
      ),
      );

  Future<Null> checkUser()async{
    //String url = 'http://192.168.1.109/Mobile/Flutter2/Train/testapp_food1/php/getUserWhereUser.php?isAdd=true&user=$user';

    String url = '${MyConstant.domain}/Mobile/Flutter2/Train/testapp_food1/php/getUserWhereUser.php?isAdd=true&user=$user';

    try {
      Response response = await Dio().get(url);
      if (response.toString().trim() == 'null') {
        registerThread();
      } else {
        normalDialog(context, 'user นี้ $user มีคนอื่นใช้ไปแล้ว กรุณาเปลี่ยน User ใหม่');
      }
    } catch (e) {
    }

  }

  // Widget registerButton() {
  //   return Container(
  //     width: 250.0,
  //     child: ElevatedButton(
  //       style: MyStyle().myButtonStyle(),
  //       onPressed: () {
  //         print(
  //             'name = $name, user = $user, password = $password, chooseType = $chooseType');
  //         //if (name == null || name.isEmpty) {
  //         //if (name?.isEmpty??true) {

  //         // OLD TYPE
  //         //if (name == null || name.isEmpty ||
  //         //    user == null || user.isEmpty ||
  //         //    password == null || password.isEmpty ||) {

  //         // New Type
  //         if ((name?.isEmpty ?? true) ||
  //             (user?.isEmpty ?? true) ||
  //             (password?.isEmpty ?? true)) {
  //           print('Have Space');
  //           normalDialog(context, 'มีช่องว่าง คะ กรุณากรอกทุกช่อง คะ');
  //         } else if (chooseType == null) {
  //           normalDialog(context, 'โปรด เลือกชนิดของผู้สมัคร');
  //         } else {
  //           print('object');
  //           registerThread();
  //         }
  //       },
  //       child: Text(
  //         'Register',
  //         style: TextStyle(color: Colors.white),
  //       ),
  //     ),
  //   );
  // }

  Future<Null> registerThread() async {
    //String url = 'http://localhost:80/Mobile/Flutter2/Train/testapp_food1/php/addUser.php?isAdd=true&choosetype=$chooseType&name=$name&user=$user&password=$password';

    //String url = 'http://192.168.1.109/Mobile/Flutter2/Train/testapp_food1/php/addUser.php?isAdd=true&choosetype=$chooseType&name=$name&user=$user&password=$password';

    

    String url = '${MyConstant.domain}/Mobile/Flutter2/Train/testapp_food1/php/addUser.php?isAdd=true&choosetype=$chooseType&name=$name&user=$user&password=$password';

        // Response response = await Dio().get(url);
        // print('res => $response');

        // try {
        //   Response response = await Dio().get(url);
        //   print('rrrreeeesss ==> $response');
        // } catch (e) {
        // }

    try {
      Response response = await Dio().get(url);
      print('res = $response');

      if (response.toString().trim() == 'true' ) {
        Navigator.pop(context);
      } else {
        normalDialog(context, 'ไม่สามารถ สมัครได้ กรุณาลองใหม่ คะ');
      }

    } catch (e) {}
  }

  Widget userRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: [
                Radio(
                  value: 'User',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value.toString();
                    });
                  },
                ),
                Text(
                  'ผู้สั่งอาหาร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget shopRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: [
                Radio(
                  value: 'Shop',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value.toString();
                    });
                  },
                ),
                Text(
                  'เจ้าของร้านอาหาร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget riderRadio() => Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 250.0,
            child: Row(
              children: [
                Radio(
                  value: 'Rider',
                  groupValue: chooseType,
                  onChanged: (value) {
                    setState(() {
                      chooseType = value.toString();
                    });
                  },
                ),
                Text(
                  'ผู้ส่งอาหาร',
                  style: TextStyle(color: MyStyle().darkColor),
                ),
              ],
            ),
          ),
        ],
      );

  Widget nameForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => name = value.trim(),
              decoration: InputDecoration(
                prefixIcon: Icon(
                  Icons.face,
                  color: MyStyle().darkColor,
                ),
                labelStyle: TextStyle(color: MyStyle().darkColor),
                labelText: 'Name :',
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().darkColor)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: MyStyle().primaryColor)),
              ),
            ),
          ),
        ],
      );

  Widget userForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
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
          ),
        ],
      );

  Widget passwordForm() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 250.0,
            child: TextField(
              onChanged: (value) => password = value.trim(),
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
          ),
        ],
      );

  Row showAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        MyStyle().showTitle('Nhong Food'),
      ],
    );
  }

  Widget myLogo() => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MyStyle().showLogo(),
        ],
      );
}
