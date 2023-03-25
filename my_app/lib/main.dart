import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'Modules/news_module.dart';
import 'package:my_app/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('SwipePage'),
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
//settings page PAGE#2
class LoginPage extends StatefulWidget {
  final String title;
  const LoginPage({Key? key, required this.title}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>  {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _rememberMe = false;
  bool _isHovering = false;

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  void _loadRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool rememberMe = prefs.getBool('rememberMe') ?? false;
    setState(() {
      _rememberMe = rememberMe;
    });
    if (_rememberMe) {
      String email = prefs.getString('email') ?? '';
      String password = prefs.getString('password') ?? '';
      emailController.text = email;
      passwordController.text = password;
    }
  }

  void _saveRememberMe() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('rememberMe', _rememberMe);
    if (_rememberMe) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    } else {
      prefs.remove('email');
      prefs.remove('password');
    }
  }

@override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
  @override
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
            Form(
  key: _formKey,
  child: Column(
    children: <Widget>[
      TextFormField(
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
        validator: (value) {
     if (emailController.text.isEmpty) {
    return 'Please enter an email address.';
  } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(emailController.text)) {
    return 'Please enter a valid email address.';
  }
  return null;
},
      ),
      const SizedBox(
        height: 26.0,
      ),
      TextFormField(
        controller: passwordController,
        cursorColor: Colors.white,
        textInputAction: TextInputAction.next,
        obscureText: true,
        decoration: const InputDecoration(
          hintText: "User Password",
          hintStyle: TextStyle(
            color: Colors.white,
          ),
          prefixIcon: Icon(Icons.lock, color: Colors.white),
        ),
        validator: (value) {
          if (passwordController.text.isEmpty) {
            return 'Please enter a password.';
          }
          return null;
        },
      ),
    ],
  ),
),
          const SizedBox(
  height: 8.0,
),
Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return ForgotPasswordForm();
            },
          );
        },
        child: Text(
          "Don't remember your Password?",
          style: TextStyle(
            color: _isHovering ? Colors.blueGrey[400] : Colors.white70,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      onHover: (PointerEvent event) {
        setState(() {
          _isHovering = true;
        });
      },
      onExit: (PointerEvent event) {
        setState(() {
          _isHovering = false;
        });
      },
    ),
    Row(
      children: [
        Checkbox(
          value: _rememberMe,
          onChanged: (value) {
            setState(() {
              _rememberMe = value!;
            });
          },
        ),
        const Text('Remember me',
         style: TextStyle(
            color: Colors.white70,),
        ),
          ],
            ),
            ],
            ),
            const SizedBox(
              height: 8.0,
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
                onPressed: () => signIn(context),
                child: const Text("Login",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18.0,
                ),
                ),
              ),
            ),
             const SizedBox(
              height: 10.0,
            ),
            Container(
              width: double.infinity,
              child: RawMaterialButton(
                fillColor: Colors.blueGrey,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
               onPressed: () {
               Navigator.push(
                context,
                MaterialPageRoute(
                 builder: (context) => CreateAccountPage(),
                ),
                );
                },
                child: const Text("Create account",
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
  Future<void> signIn(BuildContext context) async {
  try {
    UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    _saveRememberMe();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
  } on FirebaseAuthException catch (e) {
    String message;
    if (e.code == 'user-not-found') {
      message = 'No user found for that email.';
    } else if (e.code == 'wrong-password') {
      message = 'Wrong password provided.';
    } else if (e.code == 'invalid-email') {
      message = 'Please enter a valid email address.';
    } else if (e.code == 'missing-password') {
      message = 'Please enter a password.';
    } else {
      message = 'An error occurred: $e';
    }
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Sign-in Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
}
//using a CreateAccountPage
class CreateAccountPage extends StatefulWidget {
  @override
  _CreateAccountPageState createState() => _CreateAccountPageState();
}

class _CreateAccountPageState extends State<CreateAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  String _confirmPassword = '';
  String _emailError = '';
  String _passwordError = '';
  String _confirmPasswordError = '';
  String _firebaseError = '';
  final _auth = FirebaseAuth.instance;

  void _createAccount() async {
    setState(() {
      _emailError = '';
      _passwordError = '';
      _confirmPasswordError = '';
      _firebaseError = '';
    });

    if (_formKey.currentState!.validate()) {
      try {
        final newUser = await _auth.createUserWithEmailAndPassword(
            email: _email.trim(), password: _password.trim());
        Navigator.pop(context, newUser);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          setState(() {
            _passwordError = 'The password provided is too weak.';
          });
        } else if (e.code == 'email-already-in-use') {
          setState(() {
            _emailError = 'The account already exists for that email.';
          });
        } else if (e.code == 'invalid-email') {
          setState(() {
            _emailError = 'The email address is invalid.';
          });
        } else {
          setState(() {
            _firebaseError = e.message!;
          });
        }
      } catch (e) {
        setState(() {
          _firebaseError = e.toString();
        });
      }
    }
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text('Create account'),
    ),
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue.shade300, Colors.red.shade300]
        ),
      ),
        child: Padding(
      padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
               const SizedBox(height: 16.0),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                     enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                      ),
                     focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                    ),
                    labelText: 'Email',
                    hintText: 'Enter your email',
                    errorText: _emailError,
                    labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white70,
                    ),
                    hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white70,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _email = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    return null;
                  },
                ),
               const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  ),
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    errorText: _passwordError,
                    labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white70,
                    ),
                    hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white70,
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password.';
                    }
                    if (value.length < 6) {
                      return 'Your password must be at least 6 characters long.';
                    }
                    return null;
                  },
                ),
               const SizedBox(height: 16.0),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Re-enter your password',
                    errorText: _confirmPasswordError,
                    labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white70,
                    ),
                    hintStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.white70,
                    ),
                    border: const UnderlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.black,
                  ),
                  ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      _confirmPassword = value;
                    });
                  },
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please confirm your password.';
                    }
                    if (_password != _confirmPassword) {
                      return 'Passwords do not match.';
                    }
                    return null;
                  },
                ),
               const SizedBox(height: 16.0),
                if (_firebaseError.isNotEmpty)
                  Text(
                    _firebaseError,
                    style: const TextStyle(
                      color: Colors.red,
                      fontSize: 16.0,
                    ),
                  ),
               const SizedBox(height: 30.0),
                Container(
                  width: double.infinity,
                 child: RawMaterialButton(
                fillColor: Colors.blueGrey,
                elevation: 0.0,
                padding: EdgeInsets.symmetric(horizontal: MediaQuery.of(context).size.width * 0.1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0)),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _createAccount();
                      }
                    },
                    child: const Text('Create account',
                    style: TextStyle(
                  color: Colors.white70,
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
}
class ForgotPasswordForm extends StatefulWidget {
  @override
  _ForgotPasswordFormState createState() => _ForgotPasswordFormState();
}

class _ForgotPasswordFormState extends State<ForgotPasswordForm> {
  final _formKey = GlobalKey<FormState>();
  final _auth = FirebaseAuth.instance;
  late String _email;

  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email.';
    }
    return null;
  }

 void _submitForm() async {
  if (_formKey.currentState!.validate()) {
    try {
      if (_email.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Please enter your email.')));
        return;
      }
      final methods = await _auth.fetchSignInMethodsForEmail(_email);
      if (methods.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('There is no account related to that email.')));
        return;
      }
      await _auth.sendPasswordResetEmail(email: _email);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Password reset email sent.')));
      Navigator.of(context).pop();
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message!)));
    }
  }
}
 @override
Widget build(BuildContext context) {
  return Scaffold(
    body: AlertDialog(
      title: const Text('Reset Password'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'Enter your email',
              ),
              onChanged: (value) {
                setState(() {
                  _email = value;
                });
              },
              validator: _emailValidator,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('CANCEL'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text('SUBMIT'),
        ),
      ],
    ),
  );
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

//this is the play button on the first page
Widget buildElevatedButton(BuildContext context) => ElevatedButton.icon(
  //method to go to MainPage
    onPressed: (){
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
