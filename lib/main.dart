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
      title: 'Got Jokes?',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Click 4 a Joke'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

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
            Text(
              '$_joke',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          _joke = await getJoke();
          setState((){});
        },
        tooltip: 'Refresh Joke',
        child: Icon(Icons.star),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Future<String> getJoke() async {
  final url = 'https://icanhazdadjoke.com/';
  var response = await http.get(url, headers: {"Accept": "text/plain"},);

  return response.body;
  }
}
