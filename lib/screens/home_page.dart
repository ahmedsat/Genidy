import 'package:flutter/material.dart';
import 'widgets/name_icon.dart';
import 'widgets/logo.dart';
import 'widgets/category_tab.dart';
import 'widgets/custom_scaffold.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/all_products_tab.dart';

class HomePage extends StatefulWidget {
  static String id = 'HomePage';

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final _auth = Auth();

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: DefaultTabController(
        length: 3,
        child: Scaffold(
          backgroundColor: Colors.grey[300],
          appBar: AppBar(
            // elevation: 0,
            // automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            flexibleSpace: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TabBar(
                  labelColor: Colors.black,
                  tabs: [
                    Tab(
                      child: Text('الرئيسية'),
                    ),
                    Tab(
                      child: Text('كل المنتجات'),
                    ),
                    Tab(
                      child: Text('الفئات'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Logo(),
                    NameIcon(),
                  ],
                ),
              ),
              AllProductsTab(),
              CategoryTab(),
            ],
          ),
          bottomNavigationBar: CudtomBottomNavigationBar(index: 0),
        ),
      ),
    );
  }
}
