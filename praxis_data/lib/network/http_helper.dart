import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:praxis_data/network/exceptions/api_exception.dart';

class HttpHelper {

  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise, they have no effect.
  /// This is optimized for requests that anticipate a response body of type `Map<String, dynamic>`, as in a json file-type response.
  static Future<Map<String, dynamic>> invokeHttp(dynamic url, RequestType type, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;
    Map<String, dynamic> responseBody;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } catch (error) {
      rethrow;
    }
    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  /// [url] can either be a `string` or a `Uri`.
  /// The [type] can be any of the [RequestType]s.
  /// [body] and [encoding] only apply to [RequestType.post] and [RequestType.put] requests. Otherwise, they have no effect.
  /// This is optimized for requests that anticipate a response body of type `List<dynamic>`, as in a list of json objects.
  static Future<List<dynamic>> invokeHttp2(dynamic url, RequestType type, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;
    List<dynamic> responseBody;
    try {
      response = await _invoke(url, type, headers: headers, body: body, encoding: encoding);
    } on APIException {
      rethrow;
    } on SocketException {
      rethrow;
    }

    responseBody = jsonDecode(response.body);
    return responseBody;
  }

  static Future<http.Response> _invoke(dynamic url, RequestType type, {Map<String, String>? headers, dynamic body, Encoding? encoding}) async {
    http.Response response;
    try {
      switch (type) {
        case RequestType.get:
          response = await http.get(url, headers: headers);
          break;
        case RequestType.post:
          response = await http.post(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.put:
          response = await http.put(url,
              headers: headers, body: body, encoding: encoding);
          break;
        case RequestType.delete:
          response = await http.delete(url, headers: headers);
          break;
      }

      if (response.statusCode != 200) {
        Map<String, dynamic> body = jsonDecode(response.body);
        throw APIException(body['message'], response.statusCode, body['statusText']);
      }
      return response;
    } on http.ClientException {
      rethrow;
    } on SocketException catch(e) {
      throw Exception(e.osError?.message);
    } catch (error) {
      rethrow;
    }
  }
}

enum RequestType { get, post, put, delete }