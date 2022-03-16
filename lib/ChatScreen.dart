
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Chat Session'
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Stack(
        children: [
          Container(
            padding: EdgeInsets.all(8.0),
            alignment: Alignment.bottomCenter,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  style: BorderStyle.solid,
                  color: Colors.grey
                ),
                borderRadius: BorderRadius.circular(24.0),
              ),
              child: TextField(
                expands: false,

                decoration: InputDecoration(
                  hintText: 'Text message',
                  border: InputBorder.none,
                  suffixIcon: Icon(Icons.send,
                  color: Colors.grey,)
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
