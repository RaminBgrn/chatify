import 'package:chatify/models/chat_message.dart';
import 'package:chatify/models/chat_user.dart';

class Chat {
  final String uid;
  final String currentUserUid;
  final bool activity;
  final bool group;
  final List<ChatUser> members;
  List<ChatMessage> messages;
  late final List<ChatUser> _recepients;

  Chat({
    required this.uid,
    required this.currentUserUid,
    required this.members,
    required this.messages,
    required this.activity,
    required this.group,
  }) {
    _recepients = members.where((i) => i.uid != currentUserUid).toList();
  }

  List<ChatUser> recepients() {
    return _recepients;
  }

  String title() {
    return !group
        ? _recepients.first.name
        : _recepients.map((user) => user.name).join(", ");
  }

  String imageUrl() {
    return !group
        ? _recepients.first.imageURL
        : "https://e7.pngegg.com/pngimages/151/548/png-clipart-chat-room-computer-icons-online-chat-livechat-discussion-group-others-class-monochrome.png";
  }
}
