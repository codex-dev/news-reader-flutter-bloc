import 'dart:convert';

import 'package:news_app_flutter/data/services/network_service.dart';

import '../models/news.dart';

class NewsRepository {
  final NetworkService networkService;

  NewsRepository({required this.networkService});

  Future<List<Article>> getArticleList(String parameters) async {
    final response = await networkService.getNews(parameters);
    final news = newsFromJson(response.body);
    // final news = jsonDecode(response.body) as News; // causes cast error
    // final articles = news.articles.map((json) => Article.fromJson()).toList();
    return news.articles;
  }
}
