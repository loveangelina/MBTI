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
      body: Column(
        children: [
          SizedBox(height: 25,),
          Text('관심분야는 무엇인가요?'),
          SizedBox(height: 20, width: MediaQuery.of(context).size.width,),
          Container(
            width: 330,
            child: Text('관심분야를 최대 5개 선택하고, 원하는 분야의 게시글을 우선으로 볼 수 있어요',),
          ),
          CategorySelectArea(),
        ],
      )
    );
  }

  Widget CategorySelectArea() {
    return Stack(
      children: [
        Container(
          height: 550,
          width: MediaQuery.of(context).size.width,
        ),
        Positioned(
          child: StackedButton(bigText: '1', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 15,
          top: 20,
        ),
        Positioned(
          child: StackedButton(bigText: '2', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 140,
          top: 50,
        ),
        Positioned(
          child: StackedButton(bigText: '3', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 270,
          top: 70,
        ),
        Positioned(
          child: StackedButton(bigText: '4', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 60,
          top: 160,
        ),
        Positioned(
          child: StackedButton(bigText: '5', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 200,
          top: 200,
        ),
        Positioned(
          child: StackedButton(bigText: '6', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 60,
          top: 290,
        ),
        Positioned(
          child: StackedButton(bigText: '7', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 220,
          top: 340,
        ),
        Positioned(
          child: StackedButton(bigText: '8', smallText1: '1', smallText2: '2', smallText3: '3'),
          left: 100,
          top: 420,
        ),
      ],

    );
  }
/*
Widget StackedButton(bigText, smallText1, smallText2, smallText3){
  bool _bigButtonVisible = true;
  bool _smallButtonVisible = true;

  void bigButtonClicked(){
    setState(() {
      _bigButtonVisible = false;
      _smallButtonVisible = true;
    });
  }
  return Stack(
    children: [
      Container(
        child: Visibility(
          child: RawMaterialButton(
            onPressed: (){
              bigButtonClicked();
            },
            child: Text(bigText, textScaleFactor: 2),
            shape: CircleBorder(),
            fillColor: Colors.deepPurple,
          ),
          visible: _bigButtonVisible,
        ),
        height: 120,
        width: 120,
      ),

      Positioned(
        child: Container(
          child: Visibility(
            child: RawMaterialButton(
              onPressed: (){
                print('clicked');
              },
              child: Text(smallText1),
              shape: CircleBorder(),
              fillColor: Colors.blue,
            ),
            visible: _smallButtonVisible,
          ),
          height: 55,
        ),
        left: 17,
      ),

      Positioned(
        child: Container(
          child: Visibility(
            child: RawMaterialButton(
              onPressed: (){
                print('clicked');
              },
              child: Text(smallText2),
              shape: CircleBorder(),
              fillColor: Colors.blue,
            ),
            visible: _smallButtonVisible,
          ),
          height: 55,
        ),
        left: -10,
        top: 50,
      ),

      Positioned(
        child: Container(
          child: Visibility(
            child: RawMaterialButton(
              onPressed: (){
                print('clicked');
              },
              child: Text(smallText3),
              shape: CircleBorder(),
              fillColor: Colors.blue,
            ),
            visible: _smallButtonVisible,
          ),
          height: 55,
        ),
        left: 45,
        top: 50,
      ),
    ],
  );
}
*/
}

class StackedButton extends StatefulWidget {
  final dynamic bigText;
  final dynamic smallText1;
  final dynamic smallText2;
  final dynamic smallText3;

  const StackedButton({Key? key, this.bigText, this.smallText1, this.smallText2, this.smallText3}) : super(key: key);

  @override
  _StackedButtonState createState() => _StackedButtonState();
}

class _StackedButtonState extends State<StackedButton> {
  bool _bigButtonVisible = true;
  bool _smallButtonVisible = false;
  Color button1Color = Colors.grey;
  Color button2Color = Colors.grey;
  Color button3Color = Colors.grey;
  bool button1Selected = false;
  bool button2Selected = false;
  bool button3Selected = false;

  void bigButtonClicked(){
    setState(() {
      _bigButtonVisible = false;
      _smallButtonVisible = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          child: Visibility(
            child: RawMaterialButton(
              onPressed: (){
                bigButtonClicked();
              },
              child: Text(widget.bigText, textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              shape: CircleBorder(),
              fillColor: Color.fromARGB(255, 27, 7, 54),
            ),
            visible: _bigButtonVisible,
          ),
          height: 120,
          width: 120,
        ),

        Positioned(
          child: Container(
            child: Visibility(
              child: RawMaterialButton(
                onPressed: (){
                  setState(() {
                    button1Selected = !button1Selected;
                  });
                },
                child: Text(widget.smallText1),
                shape: CircleBorder(),
                fillColor: button1Selected? Colors.deepOrangeAccent : Colors.grey,
              ),
              visible: _smallButtonVisible,
            ),
            height: 55,
          ),
          top: -15,
          left: 17,
        ),

        Positioned(
          child: Container(
            child: Visibility(
              child: RawMaterialButton(
                onPressed: (){
                  setState(() {
                    button2Selected = !button2Selected;
                  });
                },
                child: Text(widget.smallText2),
                shape: CircleBorder(),
                fillColor: button2Selected? Colors.deepOrangeAccent : Colors.grey,
              ),
              visible: _smallButtonVisible,
            ),
            height: 55,
          ),
          left: -15,
          top: 50,
        ),

        Positioned(
          child: Container(
            child: Visibility(
              child: RawMaterialButton(
                onPressed: (){
                  setState(() {
                    button3Selected = !button3Selected;
                  });
                },
                child: Text(widget.smallText3),
                shape: CircleBorder(),
                fillColor: button3Selected? Colors.deepOrangeAccent : Colors.grey,
              ),
              visible: _smallButtonVisible,
            ),
            height: 55,
          ),
          left: 55,
          top: 50,
        ),
      ],
      overflow: Overflow.visible,
    );
  }
}

