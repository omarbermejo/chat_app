  // ignore_for_file: depend_on_referenced_packages

  /*
    Es archivo produce el JWT para decodificar la api extraida desde chat stream.
    Sin embargo se exporta hacia el main para poder tener mas clean code.
  */


  import 'dart:convert';

  import 'package:crypto/crypto.dart';
  import 'package:flutter/material.dart';
  import 'package:http/http.dart' as http;
  import 'package:stream_chat_flutter/stream_chat_flutter.dart';

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

  // Este metodo , intenta conectarse a la api para poder tener una conexion estable
  Future<void> watchWithRetry(Channel channel) async {
  const retries = 5;

  for (var i = 0; i < retries; i++) {
    try {
      await channel.watch();
      return;
    } catch (e) {
      debugPrint('watch() falló intento ${i + 1}: $e');
      await Future.delayed(Duration(seconds: 2 + i));
    }
  }

  throw Exception('No se pudo hacer watch() después de $retries intentos');
}


Future<String> fetchTokenFromBackend(String userId) async {
  final url = Uri.parse('http://192.168.30.157:3001/stream/token');
  debugPrint('Token URL => $url');

  try {
    final response = await http
        .post(
          url,
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode({'user_id': userId}),
        )
        .timeout(const Duration(seconds: 10));

    debugPrint('Token response => ${response.statusCode} ${response.body}');

    if (response.statusCode != 200) {
      throw Exception(
          'Token backend error: ${response.statusCode} ${response.body}');
    }

    final data = jsonDecode(response.body) as Map<String, dynamic>;
    final token = data['token'] as String?;
    if (token == null || token.isEmpty) {
      throw Exception('Respuesta inválida: falta token');
    }
    return token;
  } catch (e) {
    debugPrint('fetchTokenFromBackend failed => $e');
    rethrow;
  }
}

