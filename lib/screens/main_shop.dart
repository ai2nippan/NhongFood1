import 'package:flutter/material.dart';
import 'package:nhongfood1/utility/my_style.dart';
import 'package:nhongfood1/utility/signout_process.dart';
import 'package:nhongfood1/widget/infomation_shop.dart';
import 'package:nhongfood1/widget/list_food_manu_shop.dart';
import 'package:nhongfood1/widget/order_list_shop.dart';

class MainShop extends StatefulWidget {
  const MainShop({Key? key}) : super(key: key);

  @override
  _MainShopState createState() => _MainShopState();
}

class _MainShopState extends State<MainShop> {

  // Field
  Widget currentWidget = OrderListShop();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Shop'),
        actions: [
          IconButton(
              onPressed: () => signOutProcess(context),
              icon: Icon(Icons.exit_to_app))
        ],
      ),
      drawer: showDrawer(),body: currentWidget,
    );
  }

  Drawer showDrawer() => Drawer(
        child: ListView(
          children: [
            showHead(),
            homeMenu(),
            foodMenu(),
            infomationMenu(),
            signOutMenu(),
          ],
        ),
      );

  ListTile homeMenu() => ListTile(
        leading: Icon(Icons.home),
        title: Text('รายการอาหารที่ ลูกค้าสั่ง'),
        subtitle: Text('รายการอาหารที่ยังไม่ได้ ทำส่งลูกค้า'),
        onTap: () {
          
          setState(() {
            currentWidget = OrderListShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile foodMenu() => ListTile(
        leading: Icon(Icons.fastfood),
        title: Text('รายการอาหาร'),
        subtitle: Text('รายการอาหาร ของร้าน'),
        onTap: () {
          setState(() {
            currentWidget = ListFoodMenuShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile infomationMenu() => ListTile(
        leading: Icon(Icons.info),
        title: Text('รายละเอียด ของร้าน'),
        subtitle: Text('รายละเอียด ของร้าน พร้อม Edit'),
        onTap: () {
          setState(() {
            currentWidget = InfomationShop();
          });
          Navigator.pop(context);
        },
      );

  ListTile signOutMenu() => ListTile(
        leading: Icon(Icons.exit_to_app),
        title: Text('Sign Out'),
        subtitle: Text('Sign Out และ กลับไป หน้าแรก'),
        onTap: () => signOutProcess(context),
      );

  UserAccountsDrawerHeader showHead() {
    return UserAccountsDrawerHeader(
      decoration: MyStyle().myBoxDecoration('shop.jpg'),
      currentAccountPicture: MyStyle().showLogo(),
      accountName: Text('Name Shop'),
      accountEmail: Text('Login'),
    );
  }
}
