import 'package:flutter/material.dart';
import 'package:nhongfood1/utility/my_style.dart';
import 'package:nhongfood1/utility/signout_process.dart';

class MainRider extends StatefulWidget {
  const MainRider({Key? key}) : super(key: key);

  @override
  _MainRiderState createState() => _MainRiderState();
}

class _MainRiderState extends State<MainRider> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Rider'),
        actions: [
          IconButton(
              onPressed: () => signOutProcess(context),
              icon: Icon(Icons.exit_to_app)),
        ],
      ),
      drawer: showDrawer(),
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHead(),
            //homeMenu(),
          ],
        ),
      );

  

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('rider.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text(
        'Name Rider',
        style: TextStyle(color: MyStyle().darkColor),
      ),
      accountEmail: Text(
        'Login',
        style: TextStyle(color: MyStyle().primaryColor),
      ),
    );
  }
}
