import 'package:flutter/material.dart';
import 'constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/product.dart';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show ByteData, rootBundle;

class CustomActions extends StatelessWidget {
  static String id = 'CustomActions';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CustomActions'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          fix();
          // addProductFromXLSXFile();
        },
      ),
    );
  }
}

Future<void> addProductFromXLSXFile() async {
  ByteData data = await rootBundle.load("images/a.xlsx");
  var bytes = data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
  var excel = Excel.decodeBytes(bytes);
  for (var table in excel.tables.keys) {
    print(table); //sheet Name
    print(excel.tables[table].maxCols);
    print(excel.tables[table].maxRows);
    var rows = excel.tables[table].rows;
    for (var row in rows) {
      if (rows.indexOf(row) > 0) {
        print('${rows.indexOf(row)} ==>   Start');
        print(row[0]);
        KStore.addProduct(
          Product(
            pcategory: 'خدمات منزليه',
            pdescription: '${row[0]}',
            pimage: 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132484366.jpg',
            pname: '${row[0]}',
            // pprice: '${row[1]} جنيه',
          ),
        );
        print('${rows.indexOf(row)} ==>   OK');
      }
    }
  }
}

Future<void> fix() async {
  print('fix');
  var col = FirebaseFirestore.instance.collection(KProductCollection);

  col.get().then(
    (snapshot) {
      snapshot.docs.forEach(
        (doc) {
          // print(doc[KProductName]);
          // int index = doc[KProductPrice].indexOf('جنيه');
          // print(index);
          // String p = doc[KProductPrice].replaceAll('جنيه', '');
          try {
            // double price = double.parse(p);

            col.doc(doc.id).update(
              {
                // KProductPrice: price,
                KProductSale: 0,
              },
            );
          } catch (e) {
            KStore.deletProduct(doc.id);
          }
        },
      );
    },
  );
}

Future<void> backup() async {
  List<Product> products = [];
  var col = await FirebaseFirestore.instance.collection(KProductCollection);
  col.get().then(
    (snapshot) {
      snapshot.docs.forEach(
        (doc) {
          print(doc[KProductPrice]);

          products.add(
            Product(
              pname: ' no name',
              // pprice: ' no price',
              pdescription: 'no description',
              pcategory: 'no category',
              pimage: 'https://thumbs.dreamstime.com/b/no-image-available-icon-flat-vector-no-image-available-icon-flat-vector-illustration-132484366.jpg',
              pinfo: 'no info',
            ),
          );
        },
      );
    },
  );
}
