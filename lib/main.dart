import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/news_cubit.dart';
import 'package:news_app_flutter/data/repository/news_repository.dart';
import 'package:news_app_flutter/data/services/network_service.dart';
import 'package:news_app_flutter/presentation/screens/news_list_screen.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatelessWidget {
  const NewsApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => NewsCubit(
            repository: NewsRepository(networkService: NetworkService())),
        child: NewsListScreen(),
      ),
    );
  }
}
