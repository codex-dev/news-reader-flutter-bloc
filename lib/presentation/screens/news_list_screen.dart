import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app_flutter/cubit/nav/nav_cubit.dart';
import 'package:news_app_flutter/cubit/news/news_cubit.dart';

class NewsListScreen extends StatefulWidget {
  const NewsListScreen({Key? key}) : super(key: key);

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  final queryController = TextEditingController();
  int page = 1;
  final pageSize = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(AppBar().preferredSize.height, context),
      body: BlocBuilder<NewsCubit, NewsState>(builder: (context, state) {
        if (state is NewsInitialState) {
          return Center(
            child: Text('App just opened'),
          );
        } else if (state is NewsLoadingState) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final articlesList = (state as NewsLoadedState).articles;

        // state is NewsLoadedState
        return Center(
          child: ListView.separated(
              itemBuilder: (context, index) {
                final article = articlesList[index];

                return ListTile(
                  title: Padding(
                    child: Text(
                      article.title,
                      maxLines: 2,
                    ),
                    padding: const EdgeInsets.only(bottom: 10.0),
                  ),
                  subtitle: Text(
                    article.description ?? "",
                    maxLines: 3,
                    textAlign: TextAlign.justify,
                  ),
                  leading: CircleAvatar(
                    radius: 30.0,
                    backgroundImage: NetworkImage(article.urlToImage),
                    backgroundColor: Colors.transparent,
                  ),
                  onTap: () =>
                      BlocProvider.of<NavCubit>(context).showArticle(article),
                );
              },
              separatorBuilder: (context, index) => Divider(),
              itemCount: articlesList.length),
        );
      }),
    );
  }

  _appBar(height, BuildContext context) {
    final cubit = context.watch<NewsCubit>();

    return PreferredSize(
      preferredSize: Size(MediaQuery.of(context).size.width, height + 80),
      child: Stack(
        children: <Widget>[
          Container(
            // Background
            child: const Center(
              child: Text(
                "News Feed",
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                    color: Colors.white),
              ),
            ),
            color: Theme.of(context).primaryColor,
            height: height + 100,
            width: MediaQuery.of(context).size.width,
          ),
          Positioned(
              // To take AppBar Size only
              top: 100.0,
              left: 20.0,
              right: 20.0,
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                      controller: queryController,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search),
                            onPressed: () {
                              String params =
                                  "&q=${queryController.text}&page=$page&pageSize=$pageSize";
                              cubit.getNewsArticles(params);
                            },
                          ),
                          hintText: 'Search..',
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(10.0)),
                      textInputAction: TextInputAction.search),
                ),
              ))
        ],
      ),
    );
  }
}
