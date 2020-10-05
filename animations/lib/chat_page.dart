import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final friendName;

  const ChatPage({Key key, this.friendName}) : super(key: key);
  _ClassPageState createState() => _ClassPageState();
}

class _ClassPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.friendName),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
              suffixIcon: IconButton(
                icon: Icon(Icons.send),
                color: Colors.blue,
                onPressed: () {},
              ),
              hintText: "New message",
              labelText: "Chat"),
        ),
      ),
      body: ListView.builder(itemBuilder: (context, index) {
        return Align(
          alignment:
              index % 2 == 0 ? Alignment.bottomLeft : Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Column(
                crossAxisAlignment: index % 2 == 0
                    ? CrossAxisAlignment.start
                    : CrossAxisAlignment.end,
                children: [
                  Text("Random chat $index"),
                  Text(
                    "10:00 am",
                    style: TextStyle(color: Colors.grey, fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
