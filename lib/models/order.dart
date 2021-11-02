import 'product.dart';

class Order {
  List<Product> products;
  String docID;
  double totalprice;
  String address;
  DateTime date;
  String phone;
  String owner;
  String status;

  Order({
    this.products,
    this.address = 'بلا عنوان',
    this.docID,
    this.phone,
    this.totalprice,
    this.date,
    this.owner,
    this.status,
  });
}
