import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'model/chatRoom.dart';

class ChatPage extends StatelessWidget {
  ChatPage({Key? key}) : super(key: key);

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
        body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('chatRooms')
              .where('users', arrayContains: "test@gmail.com")
              .snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasData) {
              return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) => _buildChatRoom(documentSnapshot)).toList()
              );
            } else {
              return Container();
            }
          }
        )
    );
  }

  Widget _buildChatRoom(DocumentSnapshot snapshot) {
    ChatRoom chatRoom = ChatRoom.fromDs(snapshot);

    return ListTile(
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: Image.asset('image/logo.png').image
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
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('오후 12:47'),
                SizedBox(height: 10,),
                Chip(
                  backgroundColor: Color(0xFFEAEAEA),
                  label: Text('4'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}