import 'package:flutter/material.dart';
import '../../constants.dart';
import '../../models/product.dart';
import 'edit_product.dart';
import '../../services/store.dart';
import '../widgets/custom_popup_menu_item.dart';

class ManageProduct extends StatefulWidget {
  static String id = 'ManageProduct';
  @override
  _EditProductState createState() => _EditProductState();
}

class _EditProductState extends State<ManageProduct> {
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    // _store.getProducts();
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          child: StreamBuilder(
            stream: _store.getProducts(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Product> proudcts = [];
                for (var doc in snapshot.data.docs) {
                  var data = doc.data();
                  proudcts.add(
                    Product(
                      pid: doc.id,
                      pcategory: data[KProductCategory],
                      pdescription: data[KProductDescription],
                      pimage: data[KProductImage],
                      pname: data[KProductName],
                      pprice: double.parse(data[KProductPrice].toString()),
                    ),
                  );
                }
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: .8,
                  ),
                  itemCount: proudcts.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
                      child: GestureDetector(
                        onTapUp: (details) {
                          double dx = details.globalPosition.dx;
                          double dy = details.globalPosition.dy;
                          showMenu(
                            context: context,
                            position: RelativeRect.fromLTRB(
                              dx,
                              dy,
                              width - dx,
                              height - dy,
                            ),
                            items: [
                              CustomPopupMenuItem(
                                onClick: () {
                                  Navigator.pushNamed(
                                    context,
                                    EditProduct.id,
                                    arguments: proudcts[index],
                                  );
                                },
                                child: Text('تعديل'),
                              ),
                              CustomPopupMenuItem(
                                onClick: () {
                                  _store.deletProduct(proudcts[index].pid);
                                  Navigator.pop(context);
                                },
                                child: Text('حذف'),
                              ),
                            ],
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Positioned.fill(
                              child: Image(
                                fit: BoxFit.fill,
                                image: NetworkImage(proudcts[index].pimage),
                              ),
                            ),
                            Positioned(
                              bottom: 0,
                              child: Opacity(
                                opacity: .5,
                                child: Container(
                                  padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                                  width: width,
                                  height: 60,
                                  color: Colors.white,
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(proudcts[index].pname),
                                      Text('${proudcts[index].pprice} جنيه'),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Text('جاري تحميل البيانات'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
