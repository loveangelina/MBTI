class Users {
  String nickName;
  String id;
  String mbti;
  Map category;

  Users({required this.mbti, required this.nickName, required this.id, required this.category});

  factory Users.fromDs(dynamic data) {
    return Users(
        mbti: data['mbti'] ?? '',
        nickName: data['nickName'] ?? '',
        id: data['id'] ?? '',
        category: data['category'] ?? {}
    );
  }
}