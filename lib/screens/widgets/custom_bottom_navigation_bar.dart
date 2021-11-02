import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import '../login_screen.dart';
import '../home_page.dart';
import '../profile.dart';

class CudtomBottomNavigationBar extends StatefulWidget {
  final int index;
  const CudtomBottomNavigationBar({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _CudtomBottomNavigationBarState createState() => _CudtomBottomNavigationBarState();
}

class _CudtomBottomNavigationBarState extends State<CudtomBottomNavigationBar> {
  int _Index = 0;

  void _onItemTapped(int index) {
    if (_Index == index) return;
    setState(() {
      _Index = index;
      switch (_Index) {
        case 0:
          {
            Navigator.pushNamedAndRemoveUntil(
              context,
              HomePage.id,
              (r) => false,
            );
          }
          break;

        case 1:
          {
            Navigator.pushNamed(
              context,
              Profile.id,
            );
          }
          break;

        case 2:
          {
            _logout();
          }
          break;

        default:
          {
            print("Invalid choice");
          }
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    _Index = widget.index;
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'الرئيسية',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'الملف الشخصي',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.logout),
          label: 'تسجيل خروج',
        ),
      ],
      currentIndex: _Index,
      selectedItemColor: Colors.amber[800],
      onTap: _onItemTapped,
    );
  }

  void _logout() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.clear();
    Navigator.pushNamedAndRemoveUntil(context, LoginScreen.id, (r) => false);
  }
}
