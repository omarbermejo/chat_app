
import  'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';



class ChatsScreen extends StatelessWidget {
  const ChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, 
      appBar: AppBar(
        title: const Text('Chats'),
        actions: [
          StreamChannelHeader(),
        ],
      ),
      body: Column(
        children: [
        Expanded(flex:2, child:  StreamMessageListView()),
          StreamMessageInput(),
        ],
      )
    );
  }
}