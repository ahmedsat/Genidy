import 'package:flutter/material.dart';
import '../services/auth.dart';
import '../provider/model_hud.dart';
import '../provider/admin_mode.dart';
import '../constants.dart';
import 'home_page.dart';
import 'signup_screen.dart';
import 'admin/admin_home.dart';
import 'widgets/logo.dart';
import 'widgets/custom_text_field.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();

  final _auth = Auth();

  bool isAdmin = false;
  bool keepLoggedIn = false;

  final AdminPassword = 'Admin1234';

  String _email, _password;

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
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('حفظ تسجيل الدخول'),
                    Checkbox(
                      checkColor: Colors.white,
                      // fillColor: MaterialStateProperty.resolveWith(getColor),
                      value: keepLoggedIn,
                      onChanged: (bool value) {
                        setState(() {
                          keepLoggedIn = value;
                        });
                      },
                    ),
                  ],
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
                        if (keepLoggedIn) {
                          keepUserLoggedIn();
                        }
                        _validate(context);
                      },
                      color: KGoldColor,
                      child: Text(
                        'تسجيل الدخول',
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
                      '  ليس لديك حساب ؟',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(
                        context,
                        SignupScreen.id,
                      ),
                      child: Text('انشاء حساب'),
                    ),
                  ],
                ),
                SizedBox(
                  height: height * .05,
                ),
                Row(
                  children: <Widget>[
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false).setIsAdmin(true);
                        },
                        child: Text(
                          'I\'m an admin',
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin ? Colors.blue : Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Provider.of<AdminMode>(context, listen: false).setIsAdmin(false);
                        },
                        child: Text(
                          'I\'m a user',
                          style: TextStyle(
                            color: Provider.of<AdminMode>(context).isAdmin ? Colors.white : Colors.blue,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
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

  void keepUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(KeepLoggedIn, keepLoggedIn);
  }

  void _validate(BuildContext context) async {
    final modelHud = Provider.of<ModelHud>(context, listen: false);
    _formKey.currentState.save();
    modelHud.setLoading(true);
    if (_formKey.currentState.validate()) {
      if (Provider.of<AdminMode>(context, listen: false).isAdmin) {
        if (_password == AdminPassword) {
          try {
            modelHud.setLoading(false);
            Navigator.pushNamed(
              context,
              AdminHome.id,
            );
          } catch (e) {
            String message = e.message;
            if (message.length > 100) message = 'تم تسجيل الدخول بنجاح';
            modelHud.setLoading(false);
            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text(
                  message,
                ),
              ),
            );
          }
        } else {
          modelHud.setLoading(false);
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Error',
              ),
            ),
          );
        }
      } else {
        try {
          final userCredential = await _auth.signIn(_email, _password);
          modelHud.setLoading(false);
          Navigator.pushNamed(
            context,
            HomePage.id,
          );
          print(userCredential.user.uid);
        } catch (e) {
          String message = e.message;
          if (message.length > 100) {
            message = 'تم تسجيل الدخول بنجاح';
          }
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
    }
    modelHud.setLoading(false);
  }
}
