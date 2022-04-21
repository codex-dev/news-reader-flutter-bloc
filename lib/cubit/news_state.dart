part of 'news_cubit.dart';

abstract class NewsState extends Equatable {
  const NewsState();

  @override
  List<Object> get props => [];
}

class NewsInitialState extends NewsState {}

class NewsLoadingState extends NewsState {}

class NewsLoadedState extends NewsState {
  final List<Article> articles;

  NewsLoadedState({required this.articles});
}

class NewsLoadingErrorState extends NewsState {
  final String error;

  NewsLoadingErrorState({required this.error});
}
