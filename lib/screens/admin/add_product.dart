import 'package:flutter/material.dart';
import '../../constants.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_simple_autocomplete_form_field.dart';
import '../../models/product.dart';

class AddProduct extends StatelessWidget {
  static String id = 'AddProduct';
  String _name, _price, _description, _category, _image;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  'اضافة منتج',
                  style: TextStyle(
                    fontSize: 28,
                  ),
                ),
              ),
              SizedBox(
                height: height * .1,
              ),
              CustomSimpleAutocompleteFormField(
                hintText: 'اسم المنتج',
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

                        KStore.addProduct(
                          Product(
                            pname: _name,
                            pprice: double.parse(_price),
                            pdescription: _description,
                            pcategory: _category,
                            pimage: _image,
                          ),
                        );
                      }
                    },
                    color: KGoldColor,
                    child: Text(
                      'اضافة المنتج',
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
