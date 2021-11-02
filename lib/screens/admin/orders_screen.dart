import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/order.dart';
import 'order_details.dart';

class OrdersScreen extends StatelessWidget {
  static String id = 'OrdersScreen';

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // _store.getProducts();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: StreamBuilder(
            stream: KStore.getOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Order> orders = [];
                for (var doc in snapshot.data.docs) {
                  var data = doc.data();
                  if (data[KOrderState] != KOrderStateDeleted)
                    orders.add(
                      Order(
                        docID: doc.id,
                        totalprice: double.parse(data[KTotalPrice].toString()),
                        address: data[KAddress],
                        phone: data[KPhoneNumber],
                        status: data[KOrderState],
                        date: DateTime.parse(data[KOrderDate].toDate().toString()),
                      ),
                    );
                }

                return ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    DateTime currentPhoneDate = DateTime.now(); //DateTime

                    Duration difference = currentPhoneDate.difference(orders[index].date);
                    return Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            OrderDetails.id,
                            arguments: orders[index],
                          );
                        },
                        child: Container(
                          padding: EdgeInsets.all(10),
                          width: width,
                          // height: width / 3,
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          orders[index].phone,
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Text(
                                          orders[index].address ?? ' ',
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      ListTile(
                                        title: Text(
                                          orders[index].totalprice.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Text(
                                          '${difference.inHours} ساعة',
                                          style: TextStyle(
                                            color: Colors.black.withOpacity(0.6),
                                            fontSize: 18,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Center(
                                    child: Text(orders[index].status),
                                  ),
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
      ),
    );
  }
}
