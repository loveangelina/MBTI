import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mbti/model/users.dart';
import 'package:mbti/startPage.dart';
import 'ChatPage.dart';
import 'MyPage.dart';
import 'createArticlePage.dart';
import 'heart.dart';
import 'model/article.dart';
import 'alarm.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
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

class HomeTab extends StatelessWidget{
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            // return object of type Dialog
            return AlertDialog(
              title: new Text("알림"),
              content: new Text("정말로 종료하실건가요?"),
              actions: <Widget>[
                new FlatButton(
                  child: new Text("종료"),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => startPage()));
                  },
                ),
                new FlatButton(
                  child: new Text("취소"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xffffffff),
            elevation: 0,
            // AppBar 그림자 제거
            iconTheme: const IconThemeData(
              color: Colors.black,
            ),
            title: Row(
              children: [
                Image.asset("image/logo.png", width: 81, height: 48,),
                const Expanded(
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.go,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 15),
                        hintText: "Search..."),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.only(right: 20.0),
                  child: Icon(Icons.search),
                ),
                IconButton(
                    onPressed: (){
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const alarmTab()),
                      );
                    },
                    icon: const Icon(Icons.notification_important)),
              ],
            ),
            centerTitle: true,
            automaticallyImplyLeading: false, // AppBar의 뒤로가기 버튼 삭제
          ),
          body: ListView(
            children: [
              Container( // 나의 카테고리
                height: 130,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.0, top: 3.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('나의 카테고리',
                        style: TextStyle(
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),

                      StreamBuilder<DocumentSnapshot>(
                        //stream: FirebaseFirestore.instance.collection('users').doc(auth.currentUser!.email).snapshots(),
                          stream: FirebaseFirestore.instance.collection('users').doc('Kva4iMYOLDI1ijPnx9je').snapshots(),
                          builder: (context, snapshot) {
                            List<String> categories = [];
                            Users users = Users.fromDs(snapshot.data);
                            for(var s in users.category.values){
                              for(var c in s)
                                categories.add(c.toString());
                            }

                            if(snapshot.hasError){
                              return Container();
                            } else{
                              if(!snapshot.hasData){
                                return Container();
                              } else{
                                return Wrap(
                                  children: [
                                    for( var s in categories)
                                      _buildChipsWithRemove(s)
                                  ],
                                );
                              }
                            }
                          }
                      )
                    ],
                  ),
                ),
              ),
              const Divider( thickness: 1, color: Colors.black87, height: 0,),

              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance.collection('article').snapshots(),
                  builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    //getDocs();
                    //print('snapshot : ' + snapshot.toString() + 'enter ');



                    if (snapshot.hasError) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: Text(
                            'Something went wrong',
                          ),
                        ),
                      );
                    }

                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container(
                        color: Colors.white,
                        child: Center(
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }

                    return Container(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      color: Color(0xFFEAEAEA),
                      child: GridView( // article collection
                        padding: EdgeInsets.only(top: 10.0,
                            right: 10.0,
                            left: 10.0),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 10.0,
                          crossAxisSpacing: 10.0,
                        ),
                        children: snapshot.data!.docs.map<Widget>((DocumentSnapshot data) =>_buildCards(data)).toList(),

                      ),
                    );
                  }
              ),


            ],
          ),
          floatingActionButton: SpeedDial(
              marginBottom: 10,
              icon: Icons.add,
              activeIcon: Icons.close,
              backgroundColor: Colors.black54,
              foregroundColor: Colors.white,
              activeBackgroundColor: Colors.white,
              activeForegroundColor: Colors.black,
              buttonSize: 56.0,
              visible: true,
              closeManually: false,
              curve: Curves.bounceIn,
              overlayColor: Colors.black,
              overlayOpacity: 0.5,
              onOpen:(){},
              onClose:(){},
              elevation: 8.0,
              shape:CircleBorder(),
              children: [
                SpeedDialChild(
                  child: Icon(Icons.edit),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  label: '게시글 작성',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const CreateArticlePage()),
                    );
                  },
                ),
                SpeedDialChild(
                  child: Icon(Icons.alarm),
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                  label: '키워드 알림 설정',
                  labelStyle: TextStyle(fontSize: 18.0),
                  onTap: () => (){},
                ),
              ]
          )
      ),
    );
  }

  Widget _buildChipsWithRemove(String chip) {
    return Padding(
      child: Chip(
        backgroundColor: Color(0xFFEAEAEA),
        label: Text(chip),
        onDeleted: (){},
      ),
      padding: const EdgeInsets.only(right: 8.0),
    );
  }

  Widget _buildChips(String chip) {
    return Padding(
      child: Chip(
        backgroundColor: Color(0xFFEAEAEA),
        label: Text(chip),
      ),
      padding: const EdgeInsets.only(right: 8.0),
    );
  }

  Widget _buildCards(DocumentSnapshot data){
    Article article = Article.fromDs(data);

    print('article 작성자 id' + article.createrId);
    print(article.post.values);


    List<String> categories = [];

    print('article topic ' + article.topic.toString());
    print('article createrId ' + article.createrId.toString());
    for (var s in article.topic) {
      categories.add(s.toString());
    }
    for (var m in article.mbti)
      categories.add(m.toString());
    for (var test in categories)
      print('categories' + test);

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
                Transform(
                  child: Wrap(
                    children: [
                      _buildChips(categories[0]),
                      _buildChips(categories[1]),
                    ],
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
                          child: Text(article.post['title'].toString(),
                              style: TextStyle(fontSize: 18,
                                  fontWeight: FontWeight.bold
                              ))
                      ),
                      Container(
                          child: Text(article.post['content'].toString(),
                              style: TextStyle(fontSize: 15,
                              ))
                      )
                    ]
                )
            ),

            // Text(
            //   article.post.values.toString(),
            //   style: TextStyle(
            //       fontSize: 18,
            //       color: Colors.black54
            //   ),
            // ),

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
                                    child: Text(article.createrId,
                                        style: TextStyle(fontSize: 14
                                        ))
                                ),
                                Flexible(
                                    child: Container(
                                        width: 71,
                                        child: Text(article.createdTime,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 10.0
                                            )
                                        )
                                    )
                                ),
                              ],
                            ),
                          ]
                      )
                    ]
                )
            )

            // Container(
            //   height: 60,
            //   child: Row(
            //       children: [
            //         Container(
            //           child: Image.asset('image/logo.png'),
            //           width: 50,
            //           height: 50,
            //         ),
            //         const Padding(
            //           padding: EdgeInsets.only(right: 15),
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start ,
            //           children: [
            //             Text(article.createrId),
            //             Text(article.createdTime),
            //           ],
            //         )
            //       ]
            //   )
            // )
          ],
        ),
      ),
    );
  }
}