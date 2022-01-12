import 'package:flutter/material.dart';

class CategorySelect extends StatefulWidget {
  const CategorySelect({Key? key}) : super(key: key);

  @override
  _CategorySelectState createState() => _CategorySelectState();
}

class _CategorySelectState extends State<CategorySelect> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('관심 카테고리 설정'),
      ),
      body: CategorySelectArea(),
    );
  }

  Widget CategorySelectArea() {
    return Container(
      child: GridView.count(
        crossAxisCount: 4,
        children: [
          Positioned(
            child: FloatingActionButton(onPressed: (){}),
            left: 50,
            top: 50,
          ),
        ],
      )
    );
  }
}

