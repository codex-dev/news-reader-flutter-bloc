import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:news_app_flutter/data/models/news.dart';
import 'package:news_app_flutter/data/repository/news_repository.dart';

part 'news_state.dart';

class NewsCubit extends Cubit<NewsState> {
  final NewsRepository repository;

  NewsCubit({required this.repository}) : super(NewsInitialState());

  void getNewsArticles(String parameters) {
    emit(NewsLoadingState());

    try {
      repository
          .getArticleList(parameters)
          .then((articles) => emit(NewsLoadedState(articles: articles)));
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      emit(NewsLoadingErrorState(error: e.toString()));
    }
  }
}
