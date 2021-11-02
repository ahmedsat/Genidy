import '../../models/order.dart';
import '../../constants.dart';
import '../../models/product.dart';
import 'package:flutter/material.dart';

class OrderDetails extends StatelessWidget {
  static String id = 'OrderDetails';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    Order order = ModalRoute.of(context).settings.arguments as Order;
////////////////
    // Order order = Order(
    //   docID: 'IH0Fqh50vzeqB7qe55P0',
    //   totalprice: 4223,
    //   address: 'test',
    // );
///////////////
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: StreamBuilder(
            stream: KStore.getOrderDetails(order.docID),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> products = [];
                for (var doc in snapshot.data.docs) {
                  var data = doc.data();
                  products.add(
                    Product(
                      pid: doc.id,
                      pcategory: data[KProductCategory],
                      pdescription: data[KProductDescription],
                      pimage: data[KProductImage],
                      pname: data[KProductName],
                      pquantity: data[KProductQuantity],
                      pprice: double.parse(data[KProductPrice].toString()),
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          width: width,
                          height: width / 4,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 4,
                                child: Container(
                                  child: Text(products[index].pname),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Text(
                                    products[index].pquantity.toString(),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: CustomCheckBox(),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('لا توجد طلبات حتي الان'),
                );
              }
            },
          ),
        ),
        bottomNavigationBar: Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                color: Colors.green,
                child: Center(
                  child: GestureDetector(
                    onTap: () => KStore.updateOrder(
                      {
                        KOrderState: KOrderStateOnDelivery,
                      },
                      order.docID,
                    ),
                    child: Text('تأكيد الطلب'),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                height: 50,
                color: Colors.red,
                child: Center(
                  child: GestureDetector(
                    onTap: () => KStore.updateOrder(
                      {
                        KOrderState: KOrderStateDeleted,
                      },
                      order.docID,
                    ),
                    child: Text('حذف الطلب'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomCheckBox extends StatefulWidget {
  @override
  _CustomCheckBoxState createState() => _CustomCheckBoxState();
}

class _CustomCheckBoxState extends State<CustomCheckBox> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    Color getColor(Set<MaterialState> states) {
      const Set<MaterialState> interactiveStates = <MaterialState>{
        MaterialState.pressed,
        MaterialState.hovered,
        MaterialState.focused,
      };
      if (states.any(interactiveStates.contains)) {
        return Colors.blue;
      }
      return Colors.red;
    }

    return Checkbox(
      checkColor: Colors.white,
      fillColor: MaterialStateProperty.resolveWith(getColor),
      value: isChecked,
      onChanged: (bool value) {
        setState(
          () {
            isChecked = value;
          },
        );
      },
    );
  }
}
