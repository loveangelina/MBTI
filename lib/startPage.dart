import 'package:flutter/material.dart';
import 'mbtiSelectPage.dart';

class startPage extends StatelessWidget{
  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
          child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('image/startPage.png'),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => mbtiSelectPage()
                            )
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black,
                        //onPrimary: Colors.white,

                      ),
                      child: const Text('시작하기',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                        ),
                      )
                  ),
                ],
              )

          )
      ),
    );
  }
}