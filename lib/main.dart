// ignore_for_file: avoid_print

import 'package:chat_app/config/env.dart';
import 'package:chat_app/screens/chats/chats_screen.dart';
import 'package:chat_app/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  final client = StreamChatClient('p4q6f6afa9dj', logLevel: Level.INFO);

  runApp(MainApp(client: client));
}

class MainApp extends StatelessWidget {
  final StreamChatClient client;

  const MainApp({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
  
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppThemeCustom.darkTheme,
      builder: (context, child) => StreamChat(client: client, child: child!),
      home: ChatLoader(client: client),
    );
  }
}

class ChatLoader extends StatefulWidget {
  final StreamChatClient client;
  const ChatLoader({super.key, required this.client});

  @override
  State<ChatLoader> createState() => _ChatLoaderState();
}

class _ChatLoaderState extends State<ChatLoader> {
  static const userId = 'omarbermejo';

  Channel? channel;
  String? error;
  bool loading = true;

  @override
  void initState() {
    super.initState();
    _initChat();
  }

  Future<void> _initChat() async {
    setState(() {
      loading = true;
      error = null;
    });

    try {
      final token = await fetchTokenFromBackend(userId);
      await widget.client.connectUser(User(id: userId), token);

      final ch = widget.client.channel(
        'messaging',
        id: 'flutterdevs',
        extraData: {'members': [userId]}, 
      );

      await watchWithRetry(ch);

      setState(() {
        channel = ch;
        loading = false;
      });
    } catch (e) {
      setState(() {
        error = e.toString();
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (error != null) {
      return Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.wifi_off, size: 48),
                const SizedBox(height: 12),
                Text(
                  "No se pudo conectar:\n$error",
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _initChat,
                  child: const Text("Reintentar"),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return StreamChannel(
      channel: channel!,
      child: ChatsScreen(),
    );
  }
}
