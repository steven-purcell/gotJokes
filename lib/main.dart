import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Got Dad Jokes?',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
        scaffoldBackgroundColor: Colors.lightBlue[100],
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(
        title: 'Very Funny, Dad.',
        ),
    );
  }
}

// Create a stateful application. Instantiating the class we wiil build on.
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// Building on the stateful widget application.
class _MyHomePageState extends State<MyHomePage> {
  String _joke = "";

  _MyHomePageState() {
    getJoke().then((val) => setState(() {
          _joke = val;
        }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(50.0), // Add padding around Text widget
              child: Text(
                '$_joke',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  fontFamily: "Times New Roman",),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _joke = await getJoke();
          setState((){}); // set the new state to update the Text widget
        },
        tooltip: 'Refresh Joke',
        child: Icon(Icons.sentiment_very_satisfied),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<String> getJoke() async {
  final url = 'https://icanhazdadjoke.com/';

  var jsonString = await http.get(url, headers: {"Accept": "application/json"},);
  Map<String, dynamic> result = convert.jsonDecode(jsonString.body);
  // print(result['joke']);
  return result['joke'];
  }
}
