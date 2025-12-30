// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:stream_chat_flutter/stream_chat_flutter.dart';

/// Genera un token JWT válido para GetStream Chat usando el API Secret
///
/// NOTA: Para desarrollo es aceptable, pero en producción deberías generar
/// los tokens en tu backend para mantener el API Secret seguro.
String generateStreamToken(String userId, String apiSecret) {
  final now = DateTime.now();
  final expiresAt = now.add(const Duration(days: 1)); // Token válido por 1 día

  // Header del JWT
  final header = {'alg': 'HS256', 'typ': 'JWT'};

  // Payload del JWT
  final payload = {
    'user_id': userId,
    'exp':
        expiresAt.millisecondsSinceEpoch ~/ 1000, // Unix timestamp en segundos
  };

  // Codificar header y payload en Base64URL
  final encodedHeader = _base64UrlEncode(jsonEncode(header));
  final encodedPayload = _base64UrlEncode(jsonEncode(payload));

  // Crear la firma
  final signature = _createSignature(
    '$encodedHeader.$encodedPayload',
    apiSecret,
  );

  // Retornar el token JWT completo
  return '$encodedHeader.$encodedPayload.$signature';
}

/// Codifica un string en Base64URL (sin padding)
String _base64UrlEncode(String input) {
  final bytes = utf8.encode(input);
  final base64 = base64Encode(bytes);
  return base64.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

/// Crea la firma HMAC-SHA256
String _createSignature(String data, String secret) {
  final key = utf8.encode(secret);
  final message = utf8.encode(data);
  final hmac = Hmac(sha256, key);
  final digest = hmac.convert(message);
  // Convertir el digest (bytes) a Base64URL
  final base64 = base64Encode(digest.bytes);
  return base64.replaceAll('+', '-').replaceAll('/', '_').replaceAll('=', '');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final client = StreamChatClient('p4q6f6afa9dj', logLevel: Level.INFO);

  const userId = 'omarbermejo';
  const apiSecret =
      '3wsu7sn5zpqstmcbbrn7dws96uzjcgs8x88f5z3qgkm56539vc7u2awjypvguffv';

  // Genera el token JWT usando el API Secret
  final token = generateStreamToken(userId, apiSecret);

  try {
    await client.connectUser(User(id: userId), token);
  } catch (e) {
    print('Error al conectar usuario: $e');
    rethrow;
  }

  final channel = client.channel('messaging', id: 'flutterdevs');

  await channel.watch();

  runApp(MainApp(client: client, channel: channel));
}

class MainApp extends StatelessWidget {
  final StreamChatClient client;
  final Channel channel;

  const MainApp({super.key, required this.client, required this.channel});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) => StreamChat(client: client, child: child!),
      home: StreamChannel(channel: channel, child: _ChannelChatPage()),
    );
  }
}

class _ChannelChatPage extends StatefulWidget {
  const _ChannelChatPage();

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
          Expanded(child: StreamMessageListView()),
          StreamMessageInput(),
        ],
      ),
    );
  }
}
