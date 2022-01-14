class Users {
  String nickName;
  String id;
  String mbti;
  Map category;
  List friend;
  List like;

  Users({
    required this.mbti,
    required this.nickName,
    required this.id,
    required this.category,
    required this.friend,
    required this.like});

  factory Users.fromDs(dynamic data) {
    return Users(
        mbti: data['mbti'] ?? '',
        nickName: data['nickName'] ?? '',
        id: data['id'] ?? '',
        category: data['category'] ?? {},
        like: data['like'] ?? [''],
        friend: data['friend'] ?? ['']
    );
  }
}