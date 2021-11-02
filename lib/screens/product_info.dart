import 'package:flutter/material.dart';
import '../constants.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import 'widgets/custom_scaffold.dart';
import '../provider/cart_items.dart';

class ProductInfo extends StatefulWidget {
  static String id = 'ProductInfo';

  @override
  _ProductInfoState createState() => _ProductInfoState();
}

class _ProductInfoState extends State<ProductInfo> {
  CartItems cartItems;



  @override
  Widget build(BuildContext context) {
    cartItems = Provider.of<CartItems>(
      context,
      listen: false,
    );

    Product product = ModalRoute.of(context).settings.arguments as Product;

    // Product product = Product(
    //   pname: 'المنتج',
    //   pimage: 'https://www.pixsy.com/wp-content/uploads/2021/04/ben-sweet-2LowviVHZ-E-unsplash-1.jpeg',
    //   pinfo: "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " + "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " + "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" + "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" + "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " + "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" + "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" + "8 Description that is too long in text format(Here Data is coming from API)" + "9 Description that is too long in text format(Here Data is coming from API)" + "10 Description that is too long in text format(Here Data is coming from API)" + "1 Description that is too long in text format(Here Data is coming from API) jdlksaf j klkjjflkdsjfkddfdfsdfds " + "2 Description that is too long in text format(Here Data is coming from API) d fsdfdsfsdfd dfdsfdsf sdfdsfsd d " + "3 Description that is too long in text format(Here Data is coming from API)  adfsfdsfdfsdfdsf   dsf dfd fds fs" + "4 Description that is too long in text format(Here Data is coming from API) dsaf dsafdfdfsd dfdsfsda fdas dsad" + "5 Description that is too long in text format(Here Data is coming from API) dsfdsfd fdsfds fds fdsf dsfds fds " + "6 Description that is too long in text format(Here Data is coming from API) asdfsdfdsf fsdf sdfsdfdsf sd dfdsf" + "7 Description that is too long in text format(Here Data is coming from API) df dsfdsfdsfdsfds df dsfds fds fsd" + "8 Description that is too long in text format(Here Data is coming from API)" + "9 Description that is too long in text format(Here Data is coming from API)" + "10 Description that is too long in text format(Here Data is coming from API)  ccccccccccccc",
    //   pprice: 3,
    //   pquantity: _counter,
    // );
    for (Product p in cartItems.getProducts()) {
      if (product.pname == p.pname) {
        product = p;
      }
    }

    return CustomScaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: 250,
              width: double.infinity,
              child: Image(
                fit: BoxFit.fitHeight,
                image: NetworkImage(product.pimage),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Color(0x80d2d2d2),
              height: 50,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(false),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        product.pname,
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 26,
                        ),
                      ),
                      Icon(
                        Icons.favorite_border,
                        color: Colors.red,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 200,
            left: 0,
            right: 0,
            // child: CounterView(),
            child: Container(
              height: 50,
              color: Color(0xaad2d2d2),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      'سعر الوحدة : ' + product.pprice.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      'الكمية : ' + product.pquantity.toString(),
                      style: TextStyle(
                        color: KGoldColor,
                        fontSize: 24,
                      ),
                    ),
                    Text(
                      'الاجمالي : ' + (product.pprice * product.pquantity).toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 255,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical, //.horizontal
                child: Text(
                  product.pdescription + ' \n' + product.pinfo,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        decoration: BoxDecoration(
          color: Colors.blue,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      product.pquantity++;
                    },
                  );
                  // _incrementCounter(product.pquantity);
                },
                child: Icon(
                  Icons.add_circle_outline,
                  size: 45,
                  color: Colors.white,
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(
                    () {
                      if (product.pquantity > 1) product.pquantity--;
                    },
                  );
                  // => _decrementCounter(product.pquantity);
                },
                child: Icon(
                  Icons.remove_circle_outline,
                  size: 45,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          backgroundColor: Colors.green,
          child: Icon(
            Icons.add_shopping_cart,
          ),
          onPressed: () {
            CartItems cartItems = Provider.of<CartItems>(
              context,
              listen: false,
            );

            cartItems.addProduct(product);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text('تم اضافة ${product.pquantity.toString() + ' من ' + product.pname} الي السلة'),
              ),
            );
          },
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
