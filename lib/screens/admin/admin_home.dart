import 'package:flutter/material.dart';
import '../../constants.dart';
import 'add_product.dart';
import 'manage_product.dart';
import 'orders_screen.dart';

class AdminHome extends StatelessWidget {
  static String id = 'AdminHome';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: KGoldColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: double.infinity,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  AddProduct.id,
                );
              },
              child: Text('اضافة منتج'),
            ),
            SizedBox(
              height: height * .01,
            ),
            SizedBox(),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ManageProduct.id,
                );
              },
              child: Text('ادارة المنتجات'),
            ),
            SizedBox(
              height: height * .01,
            ),
            RaisedButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  OrdersScreen.id,
                );
              },
              child: Text('الطلبات'),
            ),
          ],
        ),
      ),
    );
  }
}
