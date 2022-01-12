import 'package:flutter/material.dart';

import 'homePage.dart';

class CategorySelectPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0, // AppBar 그림자 제거
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 50,),
            Text("관심분야는 무엇인가요?", style: TextStyle(decorationThickness: 2),),
            SizedBox(height: 20,),
            Text("관심분야를 선택하고, 원하는 분야의 게시글을 우선으로 볼 수 있어요"),
            SizedBox(height: 20,),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: CategoryButton(text: '연애',), height: 130, width: 130,),
                    Container(child: CategoryButton(text: '운동',), height: 130, width: 130,),
                    Container(child: CategoryButton(text: '게임',), height: 130, width: 130,),
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: CategoryButton(text: '공부',), height: 130, width: 130,),
                    Container(child: CategoryButton(text: '맛집',), height: 130, width: 130,),
                    Container(child: CategoryButton(text: '학교생활',), height: 130, width: 130,),
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: CategoryButton(text: '알바',), height: 130, width: 130,),
                    Container(child: CategoryButton(text: '대인관계',), height: 130, width: 130,),
                    Container(child: CategoryButton(text: '연예',), height: 130, width: 130,),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("MBTI를 모르겠어요"),
                Text("MBTI 검사 바로가기"),
                ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HomePage()
                          )
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.black,
                      //onPrimary: Colors.white,

                    ),
                    child: const Text('다음 단계',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.bold,
                      ),
                    )
                ),
              ],
            )
          ]
      ),
    );
  }

}

class CategoryButton extends StatefulWidget {
  final dynamic text;
  const CategoryButton({Key? key, this.text}) : super(key: key);

  @override
  _CategoryButtonState createState() => _CategoryButtonState();
}

class _CategoryButtonState extends State<CategoryButton> {
  bool _bigButtonVisible = true;
  bool _smallButtonVisible = false;
  bool button1Selected = false;
  bool button2Selected = false;
  bool button3Selected = false;

  void bigButtonClicked(){
    setState(() {
      _bigButtonVisible = false;
      _smallButtonVisible = true;
    });
  }

  void smallButton1Clicked(){
    setState(() {
      button1Selected = !button1Selected;
    });
  }

  void smallButton2Clicked(){
    setState(() {
      button2Selected = !button2Selected;
    });
  }

  void smallButton3Clicked(){
    setState(() {
      button3Selected = !button3Selected;
    });
  }

  void smallButton4Clicked(){
    setState(() {
      _bigButtonVisible = true;
      _smallButtonVisible = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Visibility(
          child: Container(
            height: 130,
            width: 130,
            child: RawMaterialButton(
              onPressed: (){
                bigButtonClicked();
              },
              child: Text(widget.text, textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder(),
              fillColor: Colors.black45,
            ),
          ),
          visible: _bigButtonVisible,
        ),
        Visibility(
          child: Positioned(
            child: Container(
              height: 130/2,
              width: 130/2,
              child: RawMaterialButton(
                onPressed: (){
                  smallButton1Clicked();
                },
                child: Text('test', style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(),
                fillColor: button1Selected? Colors.pinkAccent : Colors.purple,
              ),
            ),
          ),
          visible: _smallButtonVisible,
        ),
        Visibility(
          child: Positioned(
            child: Container(
              height: 130/2,
              width: 130/2,
              child: RawMaterialButton(
                onPressed: (){
                  smallButton2Clicked();
                },
                child: Text('test', style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(),
                fillColor: button2Selected? Colors.pinkAccent : Colors.purple,
              ),
            ),
            left: 65,
          ),
          visible: _smallButtonVisible,
        ),
        Visibility(
          child: Positioned(
            child: Container(
              height: 130/2,
              width: 130/2,
              child: RawMaterialButton(
                onPressed: (){
                  smallButton3Clicked();
                },
                child: Text('test', style: TextStyle(color: Colors.white),),
                shape: RoundedRectangleBorder(),
                fillColor: button3Selected? Colors.pinkAccent : Colors.purple,
              ),
            ),
            top: 65,
          ),
          visible: _smallButtonVisible,
        ),
        Visibility(
          child: Positioned(
            child: Container(
              height: 130/2,
              width: 130/2,
              child: RawMaterialButton(
                onPressed: (){
                  smallButton4Clicked();
                },
                child: Icon(Icons.arrow_back_outlined),
                shape: RoundedRectangleBorder(),
                fillColor: Colors.grey,
              ),
            ),
            left: 65,
            top: 65,
          ),
          visible: _smallButtonVisible,
        ),
      ]
    );
  }
}