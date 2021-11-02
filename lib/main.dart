/**
  TODO : 

    [x] Save log in 
    [x] log out 
    [x] user profile
      [x] user with fireStore => create documant with id
    [X] Order state
    [X] Order details
    [X] category

 */

import 'package:firebase_core/firebase_core.dart' show Firebase;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'constants.dart';
import 'provider/admin_mode.dart';
import 'provider/cart_items.dart';
import 'provider/model_hud.dart';
import 'screens/admin/add_product.dart';
import 'screens/admin/order_details.dart';
import 'screens/admin/orders_screen.dart';
import 'screens/admin/admin_home.dart';
import 'screens/admin/edit_product.dart';
import 'screens/admin/manage_product.dart';
import 'screens/profile.dart';
import 'screens/home_page.dart';
import 'screens/cart_screen.dart';
import 'screens/category_products.dart';
import 'screens/login_screen.dart';
import 'screens/product_info.dart';
import 'screens/signup_screen.dart';
import 'actions.dart';
import 'test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SharedPreferences>(
      future: SharedPreferences.getInstance(),
      builder: (
        BuildContext context,
        AsyncSnapshot<dynamic> snapshot,
      ) {
        if (!snapshot.hasData) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('جاري التحميل ...'),
              ),
            ),
          );
        } else {
          isLogin = snapshot.data.getBool(KeepLoggedIn) ?? false;
          return MultiProvider(
            providers: [
              ChangeNotifierProvider<ModelHud>(
                create: (context) => ModelHud(),
              ),
              ChangeNotifierProvider<CartItems>(
                create: (context) => CartItems(),
              ),
              ChangeNotifierProvider<AdminMode>(
                create: (context) => AdminMode(),
              ),
            ],
            child: MaterialApp(
              // initialRoute: isLogin ? CustomActions.id : LoginScreen.id,
              initialRoute: isLogin ? HomePage.id : LoginScreen.id,
              routes: {
                LoginScreen.id: (context) => LoginScreen(),
                SignupScreen.id: (context) => SignupScreen(),
                HomePage.id: (context) => HomePage(),
                AdminHome.id: (context) => AdminHome(),
                AddProduct.id: (context) => AddProduct(),
                ManageProduct.id: (context) => ManageProduct(),
                EditProduct.id: (context) => EditProduct(),
                CustomActions.id: (context) => CustomActions(),
                ProductInfo.id: (context) => ProductInfo(),
                OrdersScreen.id: (context) => OrdersScreen(),
                CartScreen.id: (context) => CartScreen(),
                OrderDetails.id: (context) => OrderDetails(),
                Profile.id: (context) => Profile(),
                CategoryProducts.id: (context) => CategoryProducts(),
                Test.id: (context) => Test(),
              },
            ),
          );
        }
      },
    );
  }
}
