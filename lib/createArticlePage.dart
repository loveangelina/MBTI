import 'package:flutter/material.dart';
import 'ArticlePage.dart';


class CreateArticlePage extends StatefulWidget {
  const CreateArticlePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<CreateArticlePage> createState() => _CreateArticlePageState();
}

class _CreateArticlePageState extends State<CreateArticlePage> {
  //TextField Controller
  final TextEditingController title = TextEditingController();
  final TextEditingController content = TextEditingController();

  //chat authority for dropdownbutton
  var dropDownList = ['모두에게', '작성자만'];
  String dropDownListValue = '모두에게';

  //if chat authority is 'all', then true
  bool option = true;

  //if title is empty, then false
  bool isFilledTitle = false;
  //if content is empty, then false
  bool isFilledContext = false;

  var MBTI = ['ENFJ', 'INFJ', 'ISTP', 'ESTP', 'ENFP', 'INFP', 'ESFP', 'ISFP', 'ESFJ', 'ISFJ', 'INTP', 'INTJ', 'ESTJ', 'ISTJ', 'ENTJ', 'ENTP'];
  var selectedMBTI = [false, false, false, false, false, false, false, false, false, false, false, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarSection(),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          titleSection(),
          contentSection(),
          mbtiSection(),
          hashTagSection(),
          authoritySettingSection(),
        ],
      ),
    );
  }

  //appbar
  PreferredSizeWidget appBarSection() {
    return AppBar(
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.clear),
        color: Colors.black,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      centerTitle: false,
      backgroundColor: Colors.white,
      title: const Text(
        '글쓰기',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          color: Colors.black,
        ),
      ),
      actions: [
        Container(
          width: 120,
          padding: EdgeInsets.only(top: 8, bottom: 8),
          child: ElevatedButton(
            child: const Text('완료'),
            style: ElevatedButton.styleFrom(
              primary: isFilledContext && isFilledTitle ? Colors.black : Colors.grey,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            onPressed: isFilledContext && isFilledTitle
                ? () {
              print(title.text);
              print(content.text);
              print(option);
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const ArticlePage()
                ),
              );
            }
                : null,
          ),
        ),
      ],
    );
  }

  //title section
  Widget titleSection() {
    return TextFormField(
      minLines: 1,
      maxLines: 1,
      controller: title,
      decoration: const InputDecoration(
        hintText: '제목',
      ),
      onChanged: (text) {
        setState(() {
          isFilledTitle = text.isNotEmpty;
        });
      },
    );
  }

  //content section
  Widget contentSection() {
    return TextFormField(
      minLines: 20,
      maxLines: 20,
      controller: content,
      decoration: const InputDecoration(
        hintText: '내용을 입력하세요',
      ),
      onChanged: (text) {
        setState(() {
          isFilledContext = text.isNotEmpty;
        });
      },
    );
  }

  //chat authority setting section
  Widget authoritySettingSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(top:20),
          child: const Text(
            '채팅 권한 설정',
            style: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        Container(
          margin: const EdgeInsets.only(left: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '1대1 채팅',
                style: TextStyle(
                  color: Colors.grey,
                ),
              ),
              DropdownButton<String>(
                value: dropDownListValue,
                items: dropDownList.map((String value) {
                  return DropdownMenuItem(
                    child: Text(value),
                    value: value,
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    dropDownListValue = value.toString();
                    option = dropDownListValue == '모두에게';
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  //hashtag Section - code change required
  Widget hashTagSection() {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: const Expanded(
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
    );
  }

  //mbti Section - in changing code
  Widget mbtiSection() {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 5),
            child: const Text(
              'MBTI 유형',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '유형 선택',
                  style: TextStyle(
                      color: Colors.grey
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.keyboard_arrow_right,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return StatefulBuilder(
                            builder: (context, setState) {
                              return AlertDialog(
                                title: const Text('MBTI 선택(다중 선택 가능)'),
                                content: Container(
                                  height: 300,
                                  width: 300,
                                  child: GridView.count(
                                    crossAxisCount: 4,
                                    children: List.generate(
                                        16, (index) => generateMBTI(index, setState)
                                    ),
                                  ),
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text(
                                      '완료',
                                      style: TextStyle(
                                          color: Colors.lightBlueAccent),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        }
                    );
                  },
                ),
              ],
            ),
          ),
          const Divider(
            thickness: 2,
            color: Colors.grey,
          ),
        ],
      ),
    );
  }

  Widget generateMBTI(int index, StateSetter setState) {
    return ElevatedButton(
      child: Text(MBTI[index]),
      style: ElevatedButton.styleFrom(
        primary: selectedMBTI[index] ? Colors.black : Colors.grey,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      onPressed: () {
        setState(() {
          selectedMBTI[index] = !selectedMBTI[index];
        });
      },
    )
    ;
  }
}
