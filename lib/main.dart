import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() async{
  final client = StreamChatClient(
    'p4q6f6afa9dj',
    logLevel: Level.INFO,
  );
 await client.connectUser(
  User(id: 'omarbermejo'),
  '3wsu7sn5zpqstmcbbrn7dws96uzjcgs8x88f5z3qgkm56539vc7u2awjypvguffv',
 );
 final channel = client.channel(
  'messaging', id: 'flutterdevs',
 );
   channel.watch();
  runApp( MainApp(client: client , channel: channel));
}

class MainApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  const MainApp({super.key, required this.client ,required this.channel});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => StreamChat(
        client: client,
        child: child!,
      ),
      home: StreamChannel(
        channel: channel,
        child: _ChannelChatPage(),
      ),
    );
  }
}

class _ChannelChatPage extends StatefulWidget {
  const _ChannelChatPage({super.key});

  @override
  State<_ChannelChatPage> createState() => __ChannelChatPageState();
}

class __ChannelChatPageState extends State<_ChannelChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: StreamChannelHeader(),
      body: Column(
        children: [
          Expanded(
            child: StreamMessageListView(),
          ),
          StreamMessageInput(),
        ]
      ),
    );}
}