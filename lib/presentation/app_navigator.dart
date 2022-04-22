import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/nav/nav_cubit.dart';
import 'package:news_app_flutter/data/models/news.dart';
import 'package:news_app_flutter/presentation/screens/news_details_screen.dart';
import 'package:news_app_flutter/presentation/screens/news_list_screen.dart';

class AppNavigator extends StatelessWidget {
  const AppNavigator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavCubit, Article?>(
      builder: ((context, article) {
        return Navigator(
          pages: [
            MaterialPage(child: NewsListScreen()),
            
            if (article != null)
              MaterialPage(
                  child: NewsDetailsScreen(
                article: article,
              ))
          ],
          onPopPage: (route, result) {
            BlocProvider.of<NavCubit>(context).popToList();
            return route.didPop(result);
          },
        );
      }),
    );
  }
}
