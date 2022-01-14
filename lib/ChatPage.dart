
import 'package:flutter/material.dart';
import 'package:mbti/ChatRoomPage.dart';

import 'model/chatRoom.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String userid = FirebaseAuth.instance.currentUser!.email.toString();
    print(userid == 'test@gmail.com');

    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: Container(), // 뒤로가기 버튼 삭제
          backgroundColor: Colors.white,
          title: const Padding(
            child: Text(
              '채팅',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
            padding: EdgeInsets.only(right: 10),
          ),
        ),
        body: ListView(
          children: [
              ElevatedButton(onPressed: () { Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ChatRoomPage(chatRoomDocName: "roomA", chatRoomTitle: "ENFJ",)),
              );
              }
              ,child: Text("임시 채팅 방"))
            ,
            ListTile(
              title: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.all(10.0),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Colors.black87,
                        shape: BoxShape.circle,
                      ),
                    ),
                    Column(
                      children: [
                        Text('제목'),
                        Padding(
                          padding: EdgeInsets.only(bottom: 10),
                        ),
                        Text('내용'),
                      ],
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 180)
                    ),
                    Column(
                      children: [
                        Text('오후 12:47'),
                        Chip(
                          backgroundColor: Color(0xFFEAEAEA),
                          label: Text('4'),
                        ),
                      ],
                    ),
                    color: Colors.black87,
                    shape: BoxShape.circle,
                  ),
                ),
                SizedBox(width: 20,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(chatRoom.roomTitle),
                    SizedBox(height: 20,),
                    Text('내용'),
                  ],
                ),
              ),
            ),
            Divider(
              height: 1,
              color: Colors.grey,
            ),
          ],
        )
    );
  }
}

