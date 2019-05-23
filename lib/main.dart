import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'dart:io' show Platform;
import 'bloc/counter_bloc.dart';
import 'bloc/counter_provider.dart';
import 'bloc/switch_bloc.dart';
import 'bloc/switch_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: switchbloc.getOS,
        initialData: SwitchProvider().isIOS,
        builder: (context, snapshot) {
          return MyHomePage(
            title: "Flutter Demo Home Page",
            isIOS: snapshot.data,
          );
        });
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, @required this.title, @required this.isIOS})
      : super(key: key);

  final String title;
  final bool isIOS;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  
  Color notificationbarColor;

  void _incrementCounter() {
    counterBloc.updateCount();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    widget.isIOS
        ? notificationbarColor = CupertinoColors.white
        : notificationbarColor = Colors.blue[700];
  }

  @override
  void dispose() {
    switchbloc.dispose();
    counterBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return widget.isIOS
        ? CupertinoApp(
            debugShowCheckedModeBanner: false,
            home: CupertinoPageScaffold(
              navigationBar: CupertinoNavigationBar(
                middle: Text(widget.title),
                trailing: CupertinoButton(
                  onPressed: _incrementCounter,
                  child: Icon(Icons.add),
                  padding: EdgeInsets.all(0),
                ),
              ),
              child: AdaptiveBody(isIOS: widget.isIOS),
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Scaffold(
              appBar: AppBar(
                title: Text(widget.title),
              ),
              body: AdaptiveBody(
                isIOS: widget.isIOS,
              ),
              floatingActionButton: FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: Icon(Icons.add),
              ), // This trailing comma makes auto-formatting nicer for build methods.
            ),
          );
  }
}

class AdaptiveBody extends StatelessWidget {
  const AdaptiveBody({
    Key key,
    @required this.isIOS,
  }) : super(key: key);

  final bool isIOS;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Counter(),
          SizedBox(height: 30),
          AdaptiveButton(isIOS),
        ],
      ),
    );
  }
}

class Counter extends StatefulWidget {
  @override
  _CounterState createState() => _CounterState();
}

class _CounterState extends State<Counter> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          StreamBuilder(
              stream: counterBloc.getCount,
              initialData: CounterProvider().currentCount,
              builder: (context, snapshot) {
                return Text(
                  '${snapshot.data}',
                  style: Theme.of(context).textTheme.display4,
                );
              }),
        ],
      ),
    );
  }
}

class AdaptiveButton extends StatelessWidget {
  final bool isIOS;
  AdaptiveButton(this.isIOS);

  switchOperatingSystem() {
    switchbloc.switchOS();
  }

  @override
  Widget build(BuildContext context) {
    return isIOS
        ? CupertinoButton(
            child: Text("Switch to android"),
            color: CupertinoColors.activeBlue,
            onPressed: () => switchOperatingSystem())
        : MaterialButton(
            child: Text(
              "Switch to ios",
              style: TextStyle(color: Colors.white),
            ),
            color: Colors.blue,
            onPressed: () => switchOperatingSystem(),
          );
  }
}
