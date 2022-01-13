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

    @override
    void dispose(){
      _idFieldController.dispose();
      _pwFieldController.dispose();
    }

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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => HomePage()),
                      );
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
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
