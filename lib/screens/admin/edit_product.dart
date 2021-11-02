import 'package:flutter/material.dart';
import '../../constants.dart';
import '../widgets/custom_text_field.dart';
import '../../models/product.dart';
import '../../services/store.dart';

class EditProduct extends StatelessWidget {
  static String id = 'EditProduct';
  String _name, _price, _description, _category, _image;
  final _formKey = GlobalKey<FormState>();
  final _store = Store();

  @override
  Widget build(BuildContext context) {
    Product product = ModalRoute.of(context).settings.arguments;
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              SizedBox(
                height: height * .1,
              ),
              Center(
                child: Text(
                  'تعديل منتج',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomTextField(
                hintText: 'اسم المنتج',
                initialValue: product.pname,
                onClick: (value) {
                  _name = value;
                },
                icon: Icon(
                  Icons.drive_file_rename_outline,
                  color: KGoldColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hintText: 'سعر المنتج',
                initialValue: product.pprice.toString(),
                onClick: (value) {
                  _price = value;
                },
                icon: Icon(
                  Icons.price_check,
                  color: KGoldColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                onClick: (value) {
                  _description = value;
                },
                hintText: 'وصف المنتج',
                initialValue: product.pdescription,
                icon: Icon(
                  Icons.description,
                  color: KGoldColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hintText: 'الفئة',
                initialValue: product.pcategory,
                onClick: (value) {
                  _category = value;
                },
                icon: Icon(
                  Icons.category,
                  color: KGoldColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              CustomTextField(
                hintText: 'صورة المنتج',
                initialValue: product.pimage,
                onClick: (value) {
                  _image = value;
                },
                icon: Icon(
                  Icons.image,
                  color: KGoldColor,
                ),
              ),
              SizedBox(
                height: height * .02,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 100,
                ),
                child: Builder(
                  builder: (context) => FlatButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    onPressed: () async {
                      if (_formKey.currentState.validate()) {
                        _formKey.currentState.save();
                        _store.editProduct(
                          ({
                            KProductName: _name,
                            KProductPrice: _price,
                            KProductDescription: _description,
                            KProductCategory: _category,
                            KProductImage: _image,
                          }),
                          product.pid,
                        );
                      }
                    },
                    color: KGoldColor,
                    child: Text(
                      'تعديل المنتج',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
