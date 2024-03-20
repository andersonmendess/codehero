import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

const kPublicKey = 'f0ec355819e52ece38cbdf954b91b43d';
const kPrivateKey = '3985d046979fb526b98150f57133b7710c5b6fd9';

class HttpService {
  static Dio build() {
    final client = Dio(
      BaseOptions(
        receiveTimeout: const Duration(seconds: 15),
        connectTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        receiveDataWhenStatusError: true,
        responseType: ResponseType.json,
        contentType: 'application/json',
        baseUrl: 'https://gateway.marvel.com/v1/public',
        headers: {
          'Referer': 'localhost',
        },
      ),
    );

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final ts = DateTime.now().millisecondsSinceEpoch;
          final hash = '$ts$kPrivateKey$kPublicKey';

          options.queryParameters.addAll({
            'ts': ts,
            'apikey': kPublicKey,
            'hash': md5.convert(utf8.encode(hash)).toString(),
          });

          return handler.next(options);
        },
      ),
    );

    return client;
  }
}
