
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:singer_app/config/api_config.dart';

class Client {
  String baseUrl = ApiConfig.baseUrl;

  Dio? _dio;
  BaseOptions options = BaseOptions(
    connectTimeout: 1000 * 300,
    receiveTimeout: 1000 * 300,
  );

  Map<String, Object>? header;

  Client();

  Client setUrlEncoded() {
    header!.remove('Content-Type');
    header!
        .putIfAbsent('Content-Type', () => 'application/x-www-form-urlencoded');
    _dio!.options.headers = header;
    return this;
  }

  setHeaders(){
    _dio!.options.headers = header;
    return this;
  }

  Client builder() {
    header = <String, Object>{};
    header!.putIfAbsent('Accept', () => 'application/json');
    header!.putIfAbsent('Content-Type', () => 'application/json');
    _dio = Dio(options);
    _dio!.interceptors.add(dioInterceptor);
    _dio!.interceptors.add(PrettyDioLogger(requestBody: true, requestHeader:true,responseHeader: true,compact:false));
    _dio!.options.baseUrl = baseUrl;
    _dio!.options.headers = header;
    return this;
  }

  Dio build() {
    _dio!.options.headers = header;
    // (_dio!.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
    //     (HttpClient client) {
    //       client.badCertificateCallback =
    //       (X509Certificate cert, String host, int port) => true;
    //   return client;
    // };
    return _dio!;
  }
}

InterceptorsWrapper dioInterceptor = InterceptorsWrapper(
  onRequest: (options, handler) {
    return handler.next(options); //continue
  },
  onResponse: (response, handler) {
    return handler.next(response); // continue
  },
  onError: (DioError e, handler) async {
    return handler.next(e); //continue
  },
);
