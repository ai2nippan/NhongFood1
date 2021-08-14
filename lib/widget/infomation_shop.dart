import 'package:flutter/material.dart';
import 'package:nhongfood1/screens/add_info_shop.dart';
import 'package:nhongfood1/utility/my_style.dart';

class InfomationShop extends StatefulWidget {
  const InfomationShop({Key? key}) : super(key: key);

  @override
  _InfomationShopState createState() => _InfomationShopState();
}

class _InfomationShopState extends State<InfomationShop> {
  void routeToAddInfo() {
    print('routeToAddInfo Work');
    MaterialPageRoute materialPageRoute = MaterialPageRoute(
      builder: (context) => AddInfoShop(),
    );
    Navigator.push(context, materialPageRoute);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        MyStyle()
            .titleCenter(context, 'ยังไม่มี ข้อมูล กรุณาเพิ่มข้อมูลด้วย คะ'),
        addAndEditButton(),
      ],
    );
  }

  Row addAndEditButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(right: 16.0, bottom: 16.0),
              child: FloatingActionButton(
                child: Icon(Icons.edit),
                onPressed: () //=> routeToAddInfo(),
                {
                  print('you click floating');
                  routeToAddInfo();
                },//=> routeToAddInfo,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
