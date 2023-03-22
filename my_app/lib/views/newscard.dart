//this class gets information from news_module.dart to build the main page
import 'package:flutter/material.dart';

import '../Modules/news_module.dart';

class NewsCard extends StatelessWidget {
  final News news;

  const NewsCard({
    Key? key,
    required this.news,
  }) : super(key: key);

  //this is the widget that holds the news information
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 10,
        left: 20,
        right: 20,
      ),
      child: SizedBox(
        height: MediaQuery.of(context).size.height / 1.4,
        width: MediaQuery.of(context).size.width,
        child: Stack(children: [
          //holds the text
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5.0),
              gradient: LinearGradient(
                colors: [
                  Colors.grey.shade100,
                  Colors.white,
                  Colors.blue.shade100,
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          //the text of the news prompt
          Center(
            child: Text(news.title),
          ),
        ]),
      ),
    );
  }

}