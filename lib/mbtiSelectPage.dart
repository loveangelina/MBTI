import 'package:flutter/material.dart';
import 'homePage.dart';

class mbtiSelectPage extends StatelessWidget{
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
          Text("당신의 MBTI는 무엇인가요?", style: TextStyle(decorationThickness: 2),),
          SizedBox(height: 20,),
          Text("자신의 성격유형을 선택하고 나와 맞는 사람들을 찾아보세요"),
          SizedBox(height: 20,),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: MBTIButton(text: 'ENFJ',), height: 100,),
                  Container(child: MBTIButton(text: 'INFJ',), height: 100,),
                  Container(child: MBTIButton(text: 'ISTP',), height: 100,),
                  Container(child: MBTIButton(text: 'ESTP',), height: 100,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: MBTIButton(text: 'ENFP',), height: 100,),
                  Container(child: MBTIButton(text: 'INFP',), height: 100,),
                  Container(child: MBTIButton(text: 'ESFP',), height: 100,),
                  Container(child: MBTIButton(text: 'ISFP',), height: 100,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: MBTIButton(text: 'ESFJ',), height: 100,),
                  Container(child: MBTIButton(text: 'ISFJ',), height: 100,),
                  Container(child: MBTIButton(text: 'INTP',), height: 100,),
                  Container(child: MBTIButton(text: 'INTJ',), height: 100,),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(child: MBTIButton(text: 'ESTJ',), height: 100,),
                  Container(child: MBTIButton(text: 'ISTJ',), height: 100,),
                  Container(child: MBTIButton(text: 'ENTJ',), height: 100,),
                  Container(child: MBTIButton(text: 'ENTP',), height: 100,),
                ],
              )
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

class MBTIButton extends StatefulWidget {
  final dynamic text;
  const MBTIButton({Key? key, this.text}) : super(key: key);

  @override
  _MBTIButtonState createState() => _MBTIButtonState();
}

class _MBTIButtonState extends State<MBTIButton> {
  bool buttonSelected = false;
  void buttonClicked(){
    setState(() {
      buttonSelected = !buttonSelected;
    });
  }
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: (){
        buttonClicked();
      },
      child: Text(widget.text, textScaleFactor: 2, style: TextStyle(color: Colors.white),),
      shape: CircleBorder(),
      fillColor: buttonSelected? Colors.pinkAccent : Colors.purple,
    );
  }
}