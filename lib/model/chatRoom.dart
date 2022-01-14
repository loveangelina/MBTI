class ChatRoom {
  List chatRoomlist;
  String roomTitle;
  ChatRoom({required this.chatRoomlist, required this.roomTitle});

  factory ChatRoom.fromDs(dynamic data) {
    return ChatRoom(
        chatRoomlist: data['users'] ?? [],
        roomTitle: data['roomTitle'] ?? ''
    );
  }
}