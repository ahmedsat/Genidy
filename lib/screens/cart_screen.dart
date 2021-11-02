import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

import 'profile.dart';
import '../constants.dart';
import '../provider/cart_items.dart';
import '../models/product.dart';
import 'widgets/custom_scaffold.dart';

class CartScreen extends StatefulWidget {
  static String id = 'CartScreen';

  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartItems cartItems;
  List<Product> products = [];
  User user;

  @override
  Widget build(BuildContext context) {
    user = FirebaseAuth.instance.currentUser;
    cartItems = Provider.of<CartItems>(
      context,
      listen: false,
    );
    products = cartItems.getProducts();
    ///////////////////
    // if (products.length == 0) {
    //   var rng = new Random();
    //   for (int i = 0; i <= 5; i++) {
    //     products.add(
    //       Product(
    //         pquantity: rng.nextInt(100),
    //         pprice: rng.nextInt(200).toDouble(),
    //       ),
    //     );
    //   }
    // }
    ///////////
    if (products.length > 0) {
      return CustomScaffold(
          backgroundColor: Colors.grey[300],
          body: ListView.builder(
            itemCount: products.length,
            itemBuilder: (BuildContext context, int index) {
              return CoustomCard(
                product: products[index],
                onClick: () {},
              );
            },
          ),
          bottomNavigationBar: Builder(
            builder: (context) => GestureDetector(
              onTap: () {
                showCustomDialog(products, context);
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
                child: Center(
                  child: Text(
                    'اطلب الان',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
          ));
    } else {
      return CustomScaffold(
        backgroundColor: Colors.grey[300],
        body: Center(
          child: Container(
            width: 300,
            child: Image(
              color: Colors.blue,
              fit: BoxFit.cover,
              image: AssetImage('images/empty-cart.png'),
            ),
          ),
        ),
      );
    }
  }

  void showCustomDialog(List<Product> products, context) async {
    double price = 0;
    bool ready = false;
    bool isCompleted = true;
    String address, phone;
    for (Product product in products) price += (product.pprice * product.pquantity);

    AlertDialog alertDialog = AlertDialog(
      title: Text('السعر الجمالي :' + price.toString() + ' جنيه'),
      content: StreamBuilder<DocumentSnapshot>(
          stream: KStore.getUserData(user.uid),
          builder: (
            BuildContext context,
            AsyncSnapshot<DocumentSnapshot> snapshot,
          ) {
            if (snapshot.hasData) {
              if (snapshot.data[KAddress].length == 0 || snapshot.data[KPhoneNumber].length == 0) isCompleted = false;
              phone = snapshot.data[KPhoneNumber];
              address = snapshot.data[KAddress];
              ready = true;
              return TextFormField(
                initialValue: snapshot.data[KAddress],
                onChanged: (value) {
                  address = value;
                },
                decoration: InputDecoration(hintText: 'ادخل العنوان'),
              );
            } else {
              return Center(
                child: Text('انتظر ...'),
              );
            }
          }),
      actions: <Widget>[
        MaterialButton(
          onPressed: () {
            if (!isCompleted)
              Navigator.pushNamedAndRemoveUntil(
                context,
                Profile.id,
                (r) => false,
              );
            else if (ready)
              try {
                KStore.storeOrders({
                  KTotalPrice: price,
                  KAddress: address,
                  KPhoneNumber: phone,
                  KOrderState: KOrderStateOpen,
                  KOrderDate: DateTime.now(),
                }, products);
                Scaffold.of(context).showSnackBar(SnackBar(
                  content: Text('تم ارسال طلبك بنجاح'),
                ));
                cartItems.clearCart();
              } catch (e) {
                print(e);
              }
          },
          child: Text('تاكيد'),
        ),
      ],
    );

    await showDialog(
      context: context,
      builder: (context) {
        return alertDialog;
      },
    ).then((val) {
      Navigator.pushNamed(
        context,
        CartScreen.id,
      );
    });
  }
}

class CoustomCard extends StatefulWidget {
  final Function onClick;
  final Product product;

  const CoustomCard({
    Key key,
    this.onClick,
    this.product,
  }) : super(key: key);

  @override
  _CoustomCardState createState() => _CoustomCardState();
}

class _CoustomCardState extends State<CoustomCard> {
  @override
  Widget build(BuildContext context) {
    CartItems cartItems;
    cartItems = Provider.of<CartItems>(
      context,
      listen: false,
    );
    double width = MediaQuery.of(context).size.width;
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        onTap: () => this.widget.onClick(),
        child: Container(
          width: width,
          height: width / 2,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  padding: EdgeInsets.all(10),
                  // color: Colors.amber,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        title: Text(
                          widget.product.pname,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          widget.product.pcategory,
                          style: TextStyle(color: Colors.black.withOpacity(0.6)),
                        ),
                      ),
                      Text(
                        widget.product.pdescription,
                        style: TextStyle(
                          // fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  widget.product.pquantity++;
                                },
                              );
                            },
                            child: Icon(Icons.add_circle_outline),
                          ),
                          Text(widget.product.pquantity.toString()),
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  if (widget.product.pquantity > 1) widget.product.pquantity--;
                                },
                              );
                            },
                            child: Icon(Icons.remove_circle_outline),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(
                                () {
                                  cartItems.deleteProduct(widget.product.pid);
                                  Navigator.pushNamed(
                                    context,
                                    CartScreen.id,
                                  );
                                },
                              );
                            },
                            child: Icon(Icons.delete),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Container(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text((widget.product.pquantity * widget.product.pprice).toString() + ' جنيه'),
                      Image(
                        image: NetworkImage(widget.product.pimage),
                      ),
                      Text(widget.product.pprice.toString() + ' جنيه'),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
