import 'package:flutter/material.dart';
import '../category_products.dart';

class CategoryTab extends StatelessWidget {
  List<String> category = [
    'مستلزمات',
    'خدمات منزليه',
    'تخفيضات',
  ];
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // padding: const EdgeInsets.all(8),
      itemCount: category.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/green-background.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          height: 50,
          child: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  CategoryProducts.id,
                  arguments: category[index],
                );
              },
              child: Text(
                category[index],
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
