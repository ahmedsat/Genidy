import 'package:flutter/material.dart';

import '../../models/product.dart';
import '../../constants.dart';
import 'package:simple_autocomplete_formfield/simple_autocomplete_formfield.dart';

class CustomSimpleAutocompleteFormField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Function onClick;
  final String initialValue;

  const CustomSimpleAutocompleteFormField({
    Key key,
    this.hintText,
    this.initialValue = '',
    this.onClick,
    this.icon = const Icon(
      Icons.description,
    ),
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {

    return StreamBuilder(
      stream: KStore.getProducts(),
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
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: SimpleAutocompleteFormField<Product>(
              itemBuilder: (context, product) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.pname,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(product.pprice.toString()),
                  ],
                ),
              ),
              onSearch: (search) async {
                return proudcts.where(
                  (product) {
                    return product.pname.toLowerCase().contains(
                              search.toLowerCase(),
                            ) ||
                        product.pprice.toString().toLowerCase().contains(
                              search.toLowerCase(),
                            );
                  },
                ).toList();
              },
              // onChanged: (value) => setState(() => selectedProduct = value),
              // onSaved: (value) => setState(() => selectedProduct = value),
              // validator: (value) {
              //   if (value == null || value.isEmpty) {
              //     return 'القيمة فارغة برجاء الادخال';
              //   }
              //   return null;
              // },
              onSaved: onClick,
              obscureText: hintText == 'ادخل كلمة المرور' ? true : false,
              // initialValue: initialValue,
              // cursorColor: KGoldColor,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: this.icon,
                filled: true,
                fillColor: Colors.lightBlue[300],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 50),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'القيمة فارغة برجاء الادخال';
                }
                return null;
              },
              onSaved: onClick,
              obscureText: hintText == 'ادخل كلمة المرور' ? true : false,
              initialValue: initialValue,
              cursorColor: KGoldColor,
              decoration: InputDecoration(
                hintText: hintText,
                prefixIcon: this.icon,
                filled: true,
                fillColor: Colors.lightBlue[300],
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.blueGrey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
