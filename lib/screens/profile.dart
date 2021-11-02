import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import '../provider/model_hud.dart';
import '../models/user.dart';
import 'widgets/logo.dart';
import 'widgets/custom_text_field.dart';
import 'widgets/custom_bottom_navigation_bar.dart';
import 'widgets/custom_scaffold.dart';

class Profile extends StatefulWidget {
  static String id = 'Profile';

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  User user;
  UserData userData;
  final _formKey = GlobalKey<FormState>();
  String _name, _address, _phone;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;

    return (user = FirebaseAuth.instance.currentUser) == null
        ? CustomScaffold()
        : CustomScaffold(
            backgroundColor: Colors.blue,
            body: StreamBuilder(
              stream: KStore.getUserData(user.uid),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (!snapshot.hasData)
                  return Center(
                    child: Text('Loading auth data ...'),
                  );
                else
                  return StreamBuilder<DocumentSnapshot>(
                    stream: KStore.getUserData(user.uid),
                    builder: (
                      BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot,
                    ) {
                      if (snapshot.hasData) {
                        return Form(
                          key: _formKey,
                          child: ListView(
                            children: <Widget>[
                              Container(
                                child: Center(
                                  child: Logo(),
                                ),
                              ),
                              SizedBox(
                                height: height * .05,
                              ),
                              CustomTextField(
                                initialValue: user.displayName,
                                hintText: 'ادخل الاسم',
                                onClick: (value) {
                                  _name = value;
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: KGoldColor,
                                ),
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              CustomTextField(
                                onClick: (value) {
                                },
                                initialValue: user.email,
                                hintText: 'ادخل البريد الالكتروني',
                                icon: Icon(
                                  Icons.email,
                                  color: KGoldColor,
                                ),
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              CustomTextField(
                                onClick: (value) {
                                  _address = value;
                                },
                                initialValue: snapshot.data[KAddress],
                                hintText: 'ادخل العنوان',
                                icon: Icon(
                                  Icons.edit_location,
                                  color: KGoldColor,
                                ),
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              CustomTextField(
                                onClick: (value) {
                                  _phone = value;
                                },
                                initialValue: snapshot.data[KPhoneNumber] ?? '',
                                hintText: 'ادخل رقم الهاتف',
                                icon: Icon(
                                  Icons.smartphone,
                                  color: KGoldColor,
                                ),
                              ),
                              SizedBox(
                                height: height * .02,
                              ),
                              // CustomTextField(
                              //   onClick: (value) {
                              //     _password = value;
                              //   },
                              //   hintText: 'ادخل كلمة المرور',
                              //   icon: Icon(
                              //     Icons.lock,
                              //     color: KGoldColor,
                              //   ),
                              // ),
                              SizedBox(
                                height: height * .05,
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
                                      final modelHud = Provider.of<ModelHud>(context, listen: false);
                                      modelHud.setLoading(true);
                                      if (_formKey.currentState.validate()) {
                                        _formKey.currentState.save();
                                        try {
                                          modelHud.setLoading(false);
                                          update(
                                            context,
                                            displayName: _name,
                                          );
                                        } catch (e) {
                                          String message = e.message;
                                          if (message.length > 100) message = 'تم انشاء الحساب بنجاح';
                                          modelHud.setLoading(false);
                                          Scaffold.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                message,
                                              ),
                                            ),
                                          );
                                        }
                                      }
                                      modelHud.setLoading(false);
                                    },
                                    color: KGoldColor,
                                    child: Text(
                                      'تحديث',
                                      style: TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      } else {
                        return Center(
                          child: Text('Loading user data ...'),
                        );
                      }
                    },
                  );
              },
            ),
            bottomNavigationBar: CudtomBottomNavigationBar(index: 1),
          );
  }

  Future<void> update(
    context, {
    String displayName,
    String photoURL,
  }) async {
    user
        .updateProfile(
      displayName: displayName ?? 'no Name',
      photoURL: photoURL ?? '',
    )
        .then((v) {
      KStore.updateUser({
        KAddress: _address,
        KPhoneNumber: _phone,
      }, user.uid);
    }).then((v) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('updated'),
        ),
      );
      setState(() {
        user = FirebaseAuth.instance.currentUser;
      });
    });
  }
}
