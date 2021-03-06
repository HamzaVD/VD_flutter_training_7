import 'package:animations/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Animations',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Chat Animations'),
    );
  }
}

// ANIMATED OPACITY
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  double sliderValue = 0.0;
  AnimationController animationController;
  Animation<double> animation;
  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(duration: Duration(seconds: 5), vsync: this);
    final curvedAnimation = CurvedAnimation(
      curve: Curves.bounceIn,
      reverseCurve: Curves.easeOut,
      parent: animationController,
    );
    animation = Tween<double>(
      begin: 0,
      end: 2 * pi,
    ).animate(curvedAnimation)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          animationController.forward();
        }
      });
    animationController.forward();
  }

  List<String> choices = <String>[
    "Item 1",
    "Item 2",
    "Item 3",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chat App"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Colors.transparent,
          elevation: 0,
          tooltip: "DRAG ME!",
          child: Draggable(
            feedback: Image.asset(
              'assets/chat.png',
              height: 45,
              color: Colors.blue[800],
            ),
            childWhenDragging: Container(),
            child: Image.asset(
              'assets/chat.png',
              height: 45,
              color: Colors.blue[800],
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: 50,
            itemBuilder: (context, index) {
              return Card(
                child: ListTile(
                  leading: Transform.rotate(
                    angle: animation.value,
                    child: Image.asset(
                      'assets/chat.png',
                      height: 35,
                    ),
                  ),
                  title: Text("Friend $index"),
                  trailing: IconButton(
                    icon: Icon(Icons.forward),
                    onPressed: () {
                      Navigator.of(context).push(CupertinoPageRoute(
                        fullscreenDialog: true,
                        builder: (context) =>
                            ChatPage(friendName: "Friend $index"),
                      ));
                      // Navigator.of(context).push(MaterialPageRoute(
                      //   builder: (context) =>
                      //       ChatPage(friendName: "Friend $index"),
                      // ));
                    },
                  ),
                ),
              );
            }));
  }
}
