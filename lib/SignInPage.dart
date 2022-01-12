import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbti/homePage.dart';
import 'package:mbti/utils/UserIdPwInputWidget.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('로그인'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Image.asset('image/fullLogo.png'),
          SizedBox(height: 50,),
          UserIdPwInputWidget(),
          SizedBox(height: 50,),
          Container(
            height: 50,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(1),
            ),
            child: RawMaterialButton(
              onPressed: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                );
              },
              child: Text('로그인', textScaleFactor: 2, style: TextStyle(color: Colors.white),),
              shape: RoundedRectangleBorder( //버튼을 둥글게 처리
                  borderRadius: BorderRadius.circular(10)),
              //shape: RoundedRectangleBorder(),
              fillColor: Colors.black,
            ),
          )
        ],
      ),
    );
  }
}
