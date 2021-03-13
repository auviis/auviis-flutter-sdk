import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'auviis_sdk.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Auviis Example',
      theme: ThemeData(
        // This is the theme of your application.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Home'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  bool isFreeTalk = false;
  bool tapDown = false;
  bool tapDownVoiceMsg = false;
  void AuviisCallback(MethodCall methodCall) {
    debugPrint('AuviisCallback:' + methodCall.method);
    if (methodCall.method == "onSDKActivated"){
      Auviis_joinChannel(123);
    }
    if (methodCall.method == "onSDKJoinChannel"){
      List args = methodCall.arguments;
      debugPrint('args: ' + args[1].toString());
      Auviis_setActiveVoiceChannel(args[1]);
    }
    if (methodCall.method == "onSDKVoiceMessageReady"){
      List args = methodCall.arguments;
      debugPrint('args: ' + args[1].toString());
      Auviis_sendVoiceChat(args[1]);
    }

  }
  @override
  void initState() {
    super.initState();
    Auviis_setCallback(AuviisCallback);

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
              'Auviis Example',
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    // Respond to button press
                    Auviis_startSDK("6785JH889bhFGKU8904","PnHDEHHEIhjjAvcgQWUbcv");
                  },
                  child: Text("One click Start"),
                ),
                OutlinedButton(
                  onPressed: () {
                    // Respond to button press
                    Auviis_stopSDK();
                  },
                  child: Text("One click Stop"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Free Talk"),
                Switch(
                  value: isFreeTalk,
                  onChanged: (value){
                    setState(() {
                      isFreeTalk=value;
                      if (isFreeTalk) {
                        Auviis_unmuteSend();
                      }else{
                        Auviis_muteSend();
                      }
                    });
                  },
                  activeTrackColor: Colors.lightBlueAccent,
                  activeColor: Colors.blue,
                ),
                GestureDetector(
                  // When the child is tapped, show a snackbar
                  onTapDown: (TapDownDetails tapdetails ) {
                    setState(() {
                      tapDown = true;
                    });
                    Auviis_unmuteSend();
                  },
                  onTapUp: (TapUpDetails tapdetails ) {
                    Auviis_muteSend();
                    setState(() {
                      tapDown = false;
                    });
                  },
                  // Our Custom Button!
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: tapDown == true ? Colors.blue : Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Text('Push To Talk'),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Auviis_speakerOut();
                  },
                  child: Text("Speaker Out"),
                ),
                OutlinedButton(
                  onPressed: () {
                    Auviis_micOut();
                  },
                  child: Text("Mic Out"),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  // When the child is tapped, show a snackbar
                  onTapDown: (TapDownDetails tapdetails ) {
                    setState(() {
                      tapDownVoiceMsg = true;
                    });
                    Auviis_recordVoice();
                  },
                  onTapUp: (TapUpDetails tapdetails ) {
                    Auviis_stopRecord();
                    setState(() {
                      tapDownVoiceMsg = false;
                    });
                  },
                  // Our Custom Button!
                  child: Container(
                    padding: EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: tapDownVoiceMsg == true ? Colors.blue : Colors.transparent,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(2.0),
                    ),
                    child: Text('Push To Send Voice Message'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
