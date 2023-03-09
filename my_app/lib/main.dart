import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'Modules/news_module.dart';
import 'package:my_app/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News Scraper',
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

//this is the first page the users will see
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade300, Colors.red.shade300],
          ),
        ),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  "Fakey Wakey",
                  style: TextStyle(
                      fontFamily: 'Roboto',
                      fontSize: 40.8,
                      color: Colors.white),
                ),
                Image.asset(
                  'assets/newspaper.png',
                  height: 240,
                  width: 240,
                  fit: BoxFit.fitHeight,
                ),
                buildElevatedButton(),
              ]),
        ),
      ),

      //this is the drawer/sidebar that holds all the pages.
      //This is just for testing, so this won't be in the final product.
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 64.0,
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.blue.shade300,
                ),
                child: const Text('Menu'),
              ),
            ),
            ListTile(
              title: const Text('Instructions'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Settings'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SecondPage(title: 'Settings');
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('MainPage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const MainPage(title: 'MainPage');
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('SwipePage'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const DismissablePage(title: 'DismissablePage');
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

//this is the play button on the first page
Widget buildElevatedButton() => ElevatedButton.icon(
    onPressed: onPressed,
    icon: const Icon(
      Icons.favorite,
      size: 0,
      color: Colors.blueAccent,
    ),
    label: const Text('PLAY'));

void onPressed() {}

//Settings button widget?
Widget buildIconButton() => IconButton(
      onPressed: () {},
      // ignore: prefer_const_constructors
      icon: Icon(Icons.settings),
      alignment: Alignment.bottomRight,
    );

//settings page
class SecondPage extends StatelessWidget {
  const SecondPage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(
              //height: 300,
              alignment: Alignment.topRight,
              child: buildIconButton(),
            ),

            // ignore: avoid_unnecessary_containers
            Container(
              height: 400,
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {},
                child: const Text('Go Back'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//This page is used for the main part of the game
class MainPage extends StatelessWidget {
  const MainPage({Key? key, required this.title}) : super(key: key);
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

/*
Test code for "Swiping" page for the main game
*/

class DismissablePage extends StatelessWidget {
  const DismissablePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: 
        Dismissible(
          background: Container(
            color: Colors.green,
            child: Icon(Icons.check), 
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Icon(Icons.cancel),
          ),
          child: Column(
            children: [
              NewsCard(news: News.news[0]),
            ],
          ),
          key: ValueKey<int>(0),
        ),
    );
  }
}


//this is used for the true and false buttons
class ChoiceButton extends StatelessWidget {
  final Color color;
  final String text1;
  final IconData icon;
  final String text2;

  const ChoiceButton({
    Key? key,
    required this.color,
    required this.text1,
    required this.icon,
    required this.text2,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 70,
        height: 60,
        child: Row(
          children: [
            Text(text1),
            Icon(
              icon,
              color: color,
            ),
            Text(text2),
          ],
        ));
  }
}

//this class gets information from news_module.dart to build the main page
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
