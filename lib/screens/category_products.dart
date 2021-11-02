import 'package:flutter/material.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/custom_scaffold.dart';
import '../provider/cart_items.dart';
import '../models/product.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import 'product_info.dart';

class CategoryProducts extends StatelessWidget {
  static String id = 'CategoryProducts';
  @override
  Widget build(BuildContext context) {
    String cat = ModalRoute.of(context).settings.arguments;
    return CustomScaffold(
      body: StreamBuilder(
        stream: KStore.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<Product> products = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              Product p = Product(
                pid: doc.id,
                pcategory: data[KProductCategory],
                pdescription: data[KProductDescription],
                pimage: data[KProductImage],
                pname: data[KProductName],
                psale: double.parse(data[KProductSale].toString()),
                pprice: double.parse(data[KProductPrice].toString()),
              );
              if (cat == 'تخفيضات') {
                if (p.psale > 0 && p.psale != p.pprice) products.add(p);
              } else {
                if (cat == p.pcategory) products.add(p);
              }
            }

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                return CoustomCard(
                  onClick: () {
                    Navigator.pushNamed(
                      context,
                      ProductInfo.id,
                      arguments: products[index],
                    );
                  },
                  title: products[index].pname,
                  id: products[index].pid,
                  price: products[index].pprice,
                  image: products[index].pimage,
                  sale: products[index].psale,
                  category: products[index].pcategory,
                  description: products[index].pdescription,
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
      bottomNavigationBar: CudtomBottomNavigationBar(index: 0),
    );
  }
}

class CoustomCard extends StatelessWidget {
  final Function onClick;
  final String title;
  final String id;
  final double price;
  final double sale;
  final String image;
  final String category;
  final String description;

  const CoustomCard({
    Key key,
    @required this.onClick,
    @required this.title,
    @required this.id,
    @required this.price,
    @required this.sale,
    @required this.image,
    @required this.category,
    @required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(8.0))),
      child: InkWell(
        onTap: () => this.onClick(),
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text(title),
              subtitle: Text(
                category,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Image.network(
              image,
              scale: 1,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                description,
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.spaceBetween,
              children: [
                FlatButton(
                  onPressed: () {},
                  child: GestureDetector(
                    onTap: () {
                      CartItems cartItems = Provider.of<CartItems>(
                        context,
                        listen: false,
                      );
                      Product product = Product(
                        pid: id,
                        pname: title,
                        pimage: image,
                        pprice: price,
                        pcategory: category,
                        pdescription: description,
                        psale: sale,
                      );
                      cartItems.addProduct(product);
                      Scaffold.of(context).showSnackBar(
                        SnackBar(
                          content: Text('تم اضافة ${product.pquantity.toString() + ' من ' + product.pname} الي السلة'),
                        ),
                      );
                    },
                    child: Icon(
                      Icons.shopping_cart,
                    ),
                  ),
                ),
                (sale > 0 && sale != price)
                    ? RichText(
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                              text: sale.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: KGoldColor,
                              ),
                            ),
                            TextSpan(
                              text: '  ',
                            ),
                            TextSpan(
                              text: price.toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 24,
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Text(
                        price.toString(),
                        style: TextStyle(
                          color: KGoldColor,
                          fontSize: 24,
                        ),
                      ),
                FlatButton(
                  onPressed: () {},
                  child: GestureDetector(
                    onTap: () {
                      print(
                        'favorite',
                      );
                    },
                    child: Icon(
                      Icons.favorite_border,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
