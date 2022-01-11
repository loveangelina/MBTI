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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text("당신의 MBTI는 무엇인가요?"),
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