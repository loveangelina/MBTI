import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'CategorySelectPage.dart';


class mbtiSelectPage extends StatefulWidget{
  @override
  State<mbtiSelectPage> createState() => _mbtiSelectPageState();
}

class _mbtiSelectPageState extends State<mbtiSelectPage> {
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('MBTI 선택', style: TextStyle(color: Colors.black),),
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
            Text("당신의 MBTI는 무엇인가요?", style: TextStyle(decorationThickness: 2), textAlign: TextAlign.center),
            SizedBox(height: 20,),
            Text("자신의 성격유형을 선택하고 나와 맞는 사람들을 찾아보세요", textAlign: TextAlign.center),
            SizedBox(height: 20,),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: MBTIButton('ENFJ',), height: 100,),
                    Container(child: MBTIButton('INFJ',), height: 100,),
                    Container(child: MBTIButton('ISTP',), height: 100,),
                    Container(child: MBTIButton('ESTP',), height: 100,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: MBTIButton('ENFP',), height: 100,),
                    Container(child: MBTIButton('INFP',), height: 100,),
                    Container(child: MBTIButton('ESFP',), height: 100,),
                    Container(child: MBTIButton('ISFP',), height: 100,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: MBTIButton('ESFJ',), height: 100,),
                    Container(child: MBTIButton('ISFJ',), height: 100,),
                    Container(child: MBTIButton('INTP',), height: 100,),
                    Container(child: MBTIButton('INTJ',), height: 100,),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(child: MBTIButton('ESTJ',), height: 100,),
                    Container(child: MBTIButton('ISTJ',), height: 100,),
                    Container(child: MBTIButton('ENTJ',), height: 100,),
                    Container(child: MBTIButton('ENTP',), height: 100,),
                  ],
                )
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
                      //UserCredential userCredential = await FirebaseAuth.instance;
                      //print(userCredential.user?.email);
                      await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser?.email).update({'mbti': getSelected()});
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CategorySelectPage()
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
          decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black
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
      ],
    );
  }

  Widget MBTIButton(text){
    return RawMaterialButton(
      onPressed: (){
        buttonClicked(text);
      },
      child: Text(text, textScaleFactor: 2, style: TextStyle(color: Colors.white),),
      shape: CircleBorder(),
      fillColor: selected[text]? Colors.pinkAccent : Colors.purple,
    );
  }

  void buttonClicked(text){
    setState(() {
      selected.updateAll((key, value) => false);
      selected[text] = true;
      print(selected);
    });
  }
}

Map selected = {
  'ENFJ' : false,
  'INFJ' : false,
  'ISTP' : false,
  'ESTP' : false,
  'ENFP' : false,
  'INFP' : false,
  'ESFP' : false,
  'ISFP' : false,
  'ESFJ' : false,
  'ISFJ' : false,
  'INTP' : false,
  'INTJ' : false,
  'ESTJ' : false,
  'ISTJ' : false,
  'ENTJ' : false,
  'ENTP' : false,
};

String getSelected(){
  String selectedMBTI = '';
  selected.forEach((key, value) {if(value == true) selectedMBTI = key;});
  return selectedMBTI;
}