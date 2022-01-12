import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mbti/CategorySelectPage.dart';
import 'package:mbti/mbtiSelectPage.dart';

void main() {
  runApp(const Start());
}

class Start extends StatelessWidget {
  const Start({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SingUpPage',
      home: SignUp(),
      theme: ThemeData(
        primaryColor: Colors.black
      ),
    );
  }
}

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        title: Text('회원가입'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView(
          children: [
            SizedBox(height: 20),
            Text('개인정보를 입력하세요', textAlign: TextAlign.center, textScaleFactor: 1.2, ),
            profileImage(),
            SizedBox(height: 20),
            inputfield(),
            SizedBox(height: 20),
            progressCircle(),
            nextButtonArea(),
          ],
        ),
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
  Widget profileImage(){
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: 200,
              width: 200,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2016/11/14/09/14/cat-1822979_1280.jpg'
                    ),
                  )
              ),
              margin: EdgeInsets.all(20),
            ),
            Positioned(
              child: Icon(
                Icons.photo_camera,
                size: 40,
              ),
              top: 190,
              left: 160,
            )
          ],
        ),
        Stack(
          children: [
            Text('닉네임', textScaleFactor: 1.3,),
            Positioned(
                left: 60,
                child: Icon(
                    Icons.create
                )
            )
          ],
          overflow: Overflow.visible,
        ),
      ],
    );
  }

  Widget inputfield(){
    return Column(
      children: [
        Container(
          width: 350,
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Username'
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 350,
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Password'
            ),
            obscureText: true,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          width: 350,
          child: TextField(
            decoration: const InputDecoration(
                border: OutlineInputBorder(),
                filled: true,
                labelText: 'Confirm Password'
            ),
            obscureText: true,
          ),
        ),
      ],
    );
  }

  Widget nextButtonArea(){
    return ButtonBar(
      children: [
        ElevatedButton(
          child: Text('다음단계'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => mbtiSelectPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            onPrimary: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(32.0),
            ),
          ),
        )
      ],
    );
  }
}