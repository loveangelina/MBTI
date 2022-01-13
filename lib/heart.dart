import 'package:flutter/material.dart';
import 'ChatPage.dart';
import 'MyPage.dart';
import 'homePage.dart';
import 'model/article.dart';

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
  Article article = Article(createrId: 'createrId', like: 5, mbti: ['ENTP'], post: {'content' : '본문', 'title' : '제목'}, topic: []);

  @override
  Widget build(BuildContext context) {
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
                              '제목' + index.toString(),
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
                                      const SizedBox(width: 7),
                                      Row(
                                          crossAxisAlignment:CrossAxisAlignment.center,
                                        children:[
                                          Column(
                                            mainAxisAlignment: MainAxisAlignment.center ,
                                            children: [
                                              Text(article.createrId),
                                              Text('00분전'),
                                            ],
                                          ),
                                          IconButton(
                                            icon: const Icon(
                                              Icons.favorite,
                                              color: Colors.pink,
                                              size: 24.0,
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
                  },
                  itemCount: 10,
                ),
              ),
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
}
