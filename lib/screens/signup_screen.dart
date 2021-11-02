import 'package:flutter/material.dart';
import '../constants.dart';
import 'login_screen.dart';
import 'home_page.dart';
import 'widgets/logo.dart';
import 'widgets/custom_text_field.dart';
import '../services/auth.dart';
import '../provider/model_hud.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class SignupScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _auth = Auth();
  String _email, _password, _name;
  static String id = 'SignupScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        backgroundColor: Colors.blue,
        body: ModalProgressHUD(
          inAsyncCall: Provider.of<ModelHud>(context).isLoading,
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height / 5,
                  ),
                  child: Center(
                    child: Logo(),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                CustomTextField(
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
                    _email = value;
                  },
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
                    _password = value;
                  },
                  hintText: 'ادخل كلمة المرور',
                  icon: Icon(
                    Icons.lock,
                    color: KGoldColor,
                  ),
                ),
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
                            final userCredential = await _auth.signUp(_email, _password);
                            userCredential.user.updateProfile(displayName: _name);
                            KStore.createUser(userCredential.user.uid);
                            modelHud.setLoading(false);
                            Navigator.pushNamed(
                              context,
                              HomePage.id,
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
                        'انشاء',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'لديك حساب بالفعل ؟  ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        LoginScreen.id,
                      ),
                      child: Text('تسجيل الدخول'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
