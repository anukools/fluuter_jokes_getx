
import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';

class CurlInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    StringBuffer buffer = StringBuffer();
    buffer.write(' \n\nHTTP POSTMAN curl request: \ncurl ');
    buffer.write('-X ');
    buffer.write(options.method);
    buffer.write(' \'');
    buffer.write(options.uri);
    buffer.write('\'');

    options.headers.forEach((key, value) {
      buffer.write('\\\n');
      buffer.write('    -H \'');
      buffer.write('$key: $value');
      buffer.write('\'');
    });

    if (options.data != null) {
      buffer.write('\\\n');
      buffer.write('-d ');
      buffer.write('\'');
      buffer.write(jsonEncode(options.data));
      buffer.write('\'');
    }
    buffer.write('\n');
    log(buffer.toString());

    handler.next(options);
  }
}