import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:my_app/green_screen.dart';
import 'package:my_app/red_screen.dart';
import 'Modules/news_module.dart';
import 'package:my_app/firebase_options.dart';
import 'package:my_app/views/loginpage.dart';
import 'how_to_play.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}
final navigatorKey = GlobalKey<NavigatorState>();

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

//this is the first page the users will see PAGE#1
class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade300,
        title: const Text('My App'),
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
                buildElevatedButton(context),
                buildElevatedButton1(context),
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
              title: const Text('StartPage'),
              textColor:Colors.red.shade300 ,
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('SwipePage'),
              textColor: Colors.red.shade300,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const SwipePage(title: 'SwipePage');
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('LoginPage'),
              textColor: Colors.red.shade300,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const LoginPage(title: 'LoginPage');
                    },
                  ),
                );
              },
            ),
            ListTile(
              title: const Text('Placeholder'),
              textColor: Colors.red.shade300,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return const Placeholder(title: 'Placeholder');
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

//settings page PAGE#2 new changes
class LoginPage extends StatefulWidget {
  final String title;
    const LoginPage({Key? key, required this.title}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage>  {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return MaterialApp (
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
       home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.shade300,
            leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
           Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage()));
            },
            ),
                      ),
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.blue.shade300, Colors.red.shade300,])
          ),
      child: Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           const Text(
              "Welcome to Fakey Wakey!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 18.0,
            ),
            const Text(
              "Login here",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
           const SizedBox(
              height: 44.0,
            ),
            TextField(
            controller: emailController,
            cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: "User Email",
                hintStyle: TextStyle(
                color: Colors.white,
                ),
                prefixIcon: Icon(Icons.mail, color: Colors.white),
              ),
            ),
            const SizedBox(
              height: 26.0,
            ),
             TextField(
              controller: passwordController,
             cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              obscureText:  true,
              decoration: const InputDecoration(
                hintText: "User Password",
                hintStyle: TextStyle(
                color: Colors.white,
                ),
                prefixIcon: Icon(Icons.lock, color: Colors.white),
              ),
            ),
           const SizedBox(
              height: 8.0,
            ),
           const Text("Don't Remember your Password?",
            style: TextStyle(color: Colors.white),
            ),
           const SizedBox(
              height: 88.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blueGrey,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
                onPressed: signIn,
                child: const Text("Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                ),
              ),
            ),
          ],
        ),
      ),
        ),
       ),
    );
  }
    Future signIn() async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Center(child: CircularProgressIndicator()),
    );
     try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
          );
     } on FirebaseAuthException catch (e) {
      print(e);
     }
     // Navigator.of(context) not working!
     navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}

//This page is used for the main part of the game PAGE#3
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

/*
Test code for "Swiping" page for the main game
*/

class SwipePage extends StatelessWidget {
  const SwipePage({Key? key, required this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Dismissible(
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

//this is the how to play button on the first page
Widget buildElevatedButton1(BuildContext context) => ElevatedButton.icon(
    //method to go to MainPage
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HowToPlay(),
        ),
      );
    },
    icon: const Icon(
      Icons.favorite,
      size: 0,
      color: Colors.blueAccent,
    ),
    label: const Text('HOW TO PLAY'));

//this is the play button on the first page
Widget buildElevatedButton(BuildContext context) => ElevatedButton.icon(
    //method to go to MainPage
    onPressed: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) {
            return const SwipePage(title: 'SwipePage');
          },
        ),
      );
    },
    icon: const Icon(
      Icons.favorite,
      size: 0,
      color: Colors.blueAccent,
    ),
    label: const Text('PLAY'));

//Settings button widget?
Widget buildIconButton(BuildContext context) => IconButton(
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const LoginPage(title: 'LoginPage');
            },
          ),
        );
      },
      // ignore: prefer_const_constructors
      icon: Icon(Icons.settings),
      alignment: Alignment.bottomRight,
    );
