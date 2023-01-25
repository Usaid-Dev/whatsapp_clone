import 'package:flutter/material.dart';

import 'package:whatsapp_clone/models/user_model.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({
    Key? key,
    required this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return const Scaffold();
  }
}
