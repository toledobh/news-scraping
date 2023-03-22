/*
Test code for "Swiping" page for the main game
*/

import 'package:flutter/material.dart';

import '../Modules/news_module.dart';
import '../main.dart';

class SwipePage extends StatelessWidget {
  const SwipePage({super.key, required String title});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Swipe Page"),
      ),
      body: 
        Dismissible(
          background: Container(
            color: Colors.green,
            child: const Icon(Icons.check), 
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: const Icon(Icons.cancel),
          ),
          key: const ValueKey<int>(0),
          child: Column(
            children: [
              Container(
              //height: 300,
              alignment: Alignment.topRight,
              child: buildIconButton(context),
            ),
              NewsCard(news: News.news[0]),
            ],
          ),
        ),
    );
  }
}
