import 'package:flutter/material.dart';
import 'package:mbti/startPage.dart';
import 'ChatPage.dart';
import 'MyPage.dart';
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
  //Article article = Article.fromDs(data);
  Article article = Article(createrId: 'createrId', like: 5, mbti: ['ENTP'], post: {'content' : '본문', 'title' : '제목'}, topic: []);

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
                height: 80,
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
                      Chip(
                        backgroundColor: Color(0xFFEAEAEA),
                        label: Text('대학생'),
                        onDeleted: (){},
                      )
                    ],
                  ),
                ),
              ),
              const Divider( thickness: 1, color: Colors.black87, height: 0,),
              Container(
                height: MediaQuery.of(context).size.height*0.7,
                color: Color(0xFFEAEAEA),
                child: GridView.builder(
                  padding: EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.0,
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  itemBuilder: (context, index) {
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
                                  child: Chip(
                                    backgroundColor: Color(0xFFEAEAEA),
                                    label: Text('대학생'),

                                  ),
                                  transform: Matrix4.identity()..scale(0.8),
                                )

                              ],
                            ),
                            Text(
                              article.post[index].toString() + index.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.black54
                              ),
                            ),
                            Padding(padding: EdgeInsets.only(bottom: 35)),
                            Container(
                                height: 60,
                                child: Row(
                                    children: [
                                      Container(
                                        child: Image.network("https://dimg.donga.com/ugc/CDB/WEEKLY/Article/5b/b3/22/85/5bb32285000ed2738de6.jpg"),
                                        width: 50,
                                        height: 50,
                                      ),
                                      const Padding(
                                        padding: EdgeInsets.only(right: 15),
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start ,
                                        children: [
                                          Text(article.createrId),
                                          Text('00분전'),
                                        ],
                                      )
                                    ]
                                )
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: 10,
                ),
              )
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
                  onTap: () => (){},
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
}


