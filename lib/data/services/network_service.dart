import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:news_app_flutter/data/models/news.dart';

class NetworkService {
  final _baseUrl = "https://newsapi.org/v2/everything?"
      "apiKey=cec0a4b71e234f658153457823545ade&language=en&sortBy=relevancy";

  Future<http.Response> getNews(String parameters) async {
    try {
      final uri = Uri.parse('$_baseUrl$parameters');
      final response = await http.get(uri);

      if (kDebugMode) {
        print(response.body);
      }

      return response;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      rethrow;
    }
  }
}
