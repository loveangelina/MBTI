import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'MyPage.dart';
import 'homePage.dart';
import 'model/article.dart';
import 'model/users.dart';


class heartPage extends StatefulWidget {
  const heartPage({Key? key}) : super(key: key);

  @override
  _heartPageState createState() => _heartPageState();
}

class _heartPageState extends State<heartPage> {
  int _selectedIndex = 2;
  var _tabScreens = [HomeTab(), ChatPage(), heartTab(), MyPage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabScreens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: _selectedIndex == 0? Icon(Icons.home_filled): Icon(Icons.home),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: _selectedIndex == 1? Icon(Icons.chat_bubble): Icon(Icons.chat_bubble_outline_rounded),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
                padding: EdgeInsets.only(top: 10),
                child: _selectedIndex == 2? Icon(Icons.favorite): Icon(Icons.favorite_border)
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Padding(
              padding: EdgeInsets.only(top: 10),
              child: _selectedIndex == 3? Icon(Icons.person): Icon(Icons.person_outline),
            ),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}


class heartTab extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.uid;
    late List friend = [];
    late List like = [];

    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
          )
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0, // AppBar 그림자 제거
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            bottom: const TabBar(
              unselectedLabelColor: Colors.black,
              labelColor: Colors.black,
              tabs: [
                Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child:Text("채팅/게시판"),
                    )
                ),Tab(text: "회원"),
              ],
              indicatorColor: Colors.black,
            ),
            automaticallyImplyLeading: true,
            title: const Text('관심'),
          ),
          body: TabBarView(
            children: [
              //     StreamBuilder<QueryDocumentSnapshot>(
              //     stream: FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.email).
              //       builder: (context, snapshot) {
              //       return
              // }
              //   ),//관심 게시글

              StreamBuilder<DocumentSnapshot>(
                  stream: FirebaseFirestore.instance.collection('users').doc('Kva4iMYOLDI1ijPnx9je').snapshots(),
                  builder: (context, snapshot) {
                    if(snapshot.hasData) {
                      Users user = Users.fromDs(snapshot.data);
                      friend = user.friend.cast();
                      like = user.like.cast();
                      print(friend);
                      print(like);
                      print(user.nickName);
                      return StreamBuilder<QuerySnapshot>(
                          stream: FirebaseFirestore.instance.collection('article')
                              .where('aid', whereIn: like) // 좋아요를 누른 게시글만 가져오게 하는 query 문
                              .snapshots(),
                          builder: (context, snapshot) {
                            if(snapshot.hasData){
                              return GridView(
                                padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1.0,
                                  mainAxisSpacing: 10.0,
                                  crossAxisSpacing: 10.0,
                                ),
                                children: snapshot.data!.docs.map((DocumentSnapshot data) =>_buildArticle(data)).toList(),
                              );
                            }
                            else{
                              return const LinearProgressIndicator();
                            }

                          }
                      );
                    } else {
                      return const LinearProgressIndicator();
                    }
                  }
              ),
              //관심 친구 목록

              ListView(
                children: <Widget>[
                  Card(
                    child: ListTile(
                      leading:
                      const CircleAvatar(
                        backgroundImage: AssetImage('image/logo.png'),
                        radius:25,
                      ),
                      title: const Text('컴공 20'),
                      subtitle: const Text('ENFJ'),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 24.0,
                        ), onPressed: () {  },
                      ),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading:
                      const CircleAvatar(//이미지 수정 필요
                        backgroundImage: AssetImage('image/logo.png'),
                        radius:25,
                      ),
                      title: const Text('hfhek'),
                      subtitle: const Text('ISFP'),
                      trailing: IconButton(
                        icon: const Icon(
                          Icons.favorite,
                          color: Colors.pink,
                          size: 24.0,
                        ), onPressed: () {  },
                      ),
                    ),
                  ),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildArticle(DocumentSnapshot data){
    Article _article = Article.fromDs(data);

    return Card(
      elevation: 4,
      margin: EdgeInsets.all(4.0),
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.only(left: 12.0, top: 6.0, bottom: 2.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Transform(//게시글 해시태그 부분: 해시태그 개수만큼 생성해야함 일단은 2개로 조건부여
                  child:
                  Chip(
                    backgroundColor: Color(0xFFEAEAEA),
                    label: Text('#'+_article.topic[0].toString()),
                  ),
                  transform: Matrix4.identity()..scale(0.8),
                ),
                Transform(
                  child:
                  Chip(
                    backgroundColor: Color(0xFFEAEAEA),
                    label: Text('#'+_article.topic[1].toString()),
                  ),
                  transform: Matrix4.identity()..scale(0.8),
                )
              ],
            ),
            Container(
                height: 80,
                child: Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      Container(
                          child: Text(_article.post['title'].toString(),
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ))
                      ),
                      Container(
                          child: Text(_article.post['content'].toString(),
                              style: TextStyle(fontSize: 15,
                              ))
                      )
                    ]
                )
            ),
            Container(
                height: 45,
                child: Row(
                    children: [
                      Container(
                        child: Image.network("https://dimg.donga.com/ugc/CDB/WEEKLY/Article/5b/b3/22/85/5bb32285000ed2738de6.jpg"),
                        width: 50,
                        height: 50,
                      ),
                      const SizedBox(width: 1),
                      Row(
                          children:[
                            Column(
                              crossAxisAlignment:CrossAxisAlignment.start,
                              children: [
                                Container(
                                    width: 70,
                                    child: Text(_article.createrId,
                                        style: TextStyle(fontSize: 14
                                        ))
                                ),
                                Flexible(
                                    child: Container(
                                        width: 71,
                                        child: Text(_article.createdTime,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10.0
                                            )
                                        )
                                    )
                                ),
                                // Container(
                                //   child: Text(_article.createdTime,style: TextStyle(fontSize: 10))
                                // )
                                // Text(_article.createrId),
                                // Text('5분전'),
                                // Text(_article.createdTime),
                              ],
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.favorite,
                                color: Colors.pink,
                                size: 18.0,
                              ), onPressed: () {  },
                            ),
                          ]
                      )
                    ]
                )
            )
          ],
        ),
      ),
    );
  }
}

