import 'dart:convert';

import 'package:code_hero/constants.dart';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';

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
        baseUrl: kMarvelApiBaseUrl,
      ),
    );

    client.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          final ts = DateTime.now().millisecondsSinceEpoch;
          final hash = '$ts$kMarvelApiPrivateToken$kMarvelApiPublicToken';

          options.queryParameters.addAll({
            'ts': ts,
            'apikey': kMarvelApiPublicToken,
            'hash': md5.convert(utf8.encode(hash)).toString(),
          });

          return handler.next(options);
        },
      ),
    );

    return client;
  }
}
