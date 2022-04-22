import 'package:news_app_flutter/data/models/news.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavCubit extends Cubit<Article?> {
  NavCubit() : super(null);

  void showArticle(Article article) => emit(article);

  void popToList() => emit(null);
}
