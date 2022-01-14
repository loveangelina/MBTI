import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'homePage.dart';

class CategorySelectPage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    resetSelected();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xffffffff),
        elevation: 0, // AppBar 그림자 제거
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(height: 50,),
            Text("관심분야는 무엇인가요?", style: TextStyle(decorationThickness: 2), textAlign: TextAlign.center,),
            SizedBox(height: 20,),
            Text("관심분야를 선택하고, 원하는 분야의 게시글을 우선으로 볼 수 있어요", textAlign: TextAlign.center),
            SizedBox(height: 20,),
            Column(
              //mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: CategoryButton(bigText: '연애', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                    Container(child: CategoryButton(bigText: '운동', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                    Container(child: CategoryButton(bigText: '게임', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: CategoryButton(bigText: '공부', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                    Container(child: CategoryButton(bigText: '맛집', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                    Container(child: CategoryButton(bigText: '학교생활', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                  ],
                ),
                SizedBox(height: 6,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: CategoryButton(bigText: '알바', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                    Container(child: CategoryButton(bigText: '대인관계', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                    Container(child: CategoryButton(bigText: '연예', smallText1: 'test1', smallText2: 'test2', smallText3: 'test3',), height: 130, width: 130,),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20,),
            progressCircle(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("MBTI를 모르겠어요"),
                Text("MBTI 검사 바로가기"),
                ElevatedButton(
                    onPressed: () async {
                      initFirebase();
                      resetSelected();
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
  Widget progressCircle(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)
          ),
        ),
        SizedBox(width: 3,),
        Container(
          height: 13,
          width: 13,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black)
          ),
        ),
        SizedBox(width: 3,),
        Container(
          height: 13,
          width: 13,
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black
          ),
        ),
      ],
    );
  }
  initFirebase() async {
    FirebaseFirestore.instance.collection('users')
          .doc(FirebaseAuth.instance.currentUser?.email)
          .update({'category': selected});
  }
}

class CategoryButton extends StatefulWidget {
  final dynamic bigText;
  final dynamic smallText1;
  final dynamic smallText2;
  final dynamic smallText3;
  const CategoryButton({Key? key, this.bigText, this.smallText1, this.smallText2, this.smallText3}) : super(key: key);

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

  void smallButton1Clicked(text){
    setState(() {
      button1Selected = !button1Selected;
      if(button1Selected){
        selected[widget.bigText].add(text);
      }
      else{
        selected[widget.bigText].remove(text);
      }
      print(selected);
    });
  }

  void smallButton2Clicked(text){
    setState(() {
      button2Selected = !button2Selected;
      if(button2Selected){
        selected[widget.bigText].add(text);
      }
      else{
        selected[widget.bigText].remove(text);
      }
      print(selected);
    });
  }

  void smallButton3Clicked(text){
    setState(() {
      button3Selected = !button3Selected;
      if(button3Selected){
        selected[widget.bigText].add(text);
      }
      else{
        selected[widget.bigText].remove(text);
      }
      print(selected);
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
              child: Text(widget.bigText, textScaleFactor: 2, style: TextStyle(color: Colors.white),),
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
                  smallButton1Clicked(widget.smallText1);
                },
                child: Text(widget.smallText1, style: TextStyle(color: Colors.white),),
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
                  smallButton2Clicked(widget.smallText2);
                },
                child: Text(widget.smallText2, style: TextStyle(color: Colors.white),),
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
                  smallButton3Clicked(widget.smallText3);
                },
                child: Text(widget.smallText3, style: TextStyle(color: Colors.white),),
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

Map selected = {
  '연애': [],
  '운동': [],
  '게임': [],
  '공부': [],
  '맛집': [],
  '학교생활': [],
  '알바': [],
  '대인관계': [],
  '연예': [],
};

void resetSelected(){
  selected.forEach((key, value) {value.clear();});
}