import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mbti/homePage.dart';
import 'package:mbti/utils/UserIdPwInputWidget.dart';

class SignIn extends StatelessWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _idFieldController = TextEditingController();
    final _pwFieldController = TextEditingController();

    return Scaffold(

      appBar: AppBar(
        title: Text('로그인'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50,),
              Image.asset('image/fullLogo.png'),
              SizedBox(height: 50,),
              SizedBox(
                width: 350,
                child: TextField(
                  controller: _idFieldController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(), filled: true, labelText: 'Email'),
                ),
              ),
              SizedBox(height: 20,width: 1000,),
              SizedBox(
                width: 350,
                child: TextField(
                  obscureText: true,
                  controller: _pwFieldController,
                  decoration: InputDecoration(
                      border: const OutlineInputBorder(), filled: true, labelText: 'Password'),
                ),
              ),
              SizedBox(height: 50,),
              Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(1),
                ),
                child: RawMaterialButton(
                  onPressed: () async {
                    try {
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _idFieldController.text,
                          password: _pwFieldController.text,
                      );
                      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => HomePage()));
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("인증오류"),
                              content: new Text("아이디가 존재하지 않습니다."),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      } else if (e.code == 'wrong-password') {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            // return object of type Dialog
                            return AlertDialog(
                              title: new Text("인증오류"),
                              content: new Text("비밀번호가 틀립니다."),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Close"),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }
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
        ]
      ),
    );
  }
}
