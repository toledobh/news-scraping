//This page is used for the main part of the game PAGE#3
import 'package:flutter/material.dart';
import 'package:my_app/main.dart';

import '../Modules/news_module.dart';

class Placeholder extends StatelessWidget {
  const Placeholder({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          NewsCard(news: News.news[0]),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 8.0,
              horizontal: 60.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ChoiceButton(
                    color: Colors.red.shade300,
                    text1: '',
                    icon: Icons.arrow_back_rounded,
                    text2: 'FALSE'),
                ChoiceButton(
                    color: Colors.green.shade300,
                    text1: 'TRUE',
                    icon: Icons.arrow_forward_rounded,
                    text2: ''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}