
import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/ChatScreen.dart';
import 'package:my_first_flutter_app/FriendsModel.dart';

class FriendPage extends StatefulWidget {
  final Friend friend;
  FriendPage(this.friend);
  @override
  _FriendPageState createState() => _FriendPageState();
}

class _FriendPageState extends State<FriendPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            primary: true,
            expandedHeight: MediaQuery.of(context).size.height*0.6,
            pinned: true,
            // snap: true,
            // floating: true,
            //actionsIconTheme: IconThemeData(opacity: 0.0),
            actions: [
              IconButton(icon: Icon(Icons.star_border, color: Colors.white,), onPressed: (){},),
              IconButton(icon: Icon(Icons.more_vert_outlined, color: Colors.white,), onPressed: (){},),
            ],
            bottom: AppBar(
              backgroundColor: Colors.transparent,
              automaticallyImplyLeading: false,
              title: Text(widget.friend.name,
              style: TextStyle(
                fontSize: 24,
              ),),
            ),
            flexibleSpace: Stack(
              children: [
                Positioned.fill(child: Image(
                  image: AssetImage('asset/' + widget.friend.image,),
                  fit: BoxFit.cover,
                ))
              ],
            ),

          ),
          SliverList(delegate: SliverChildListDelegate(
            [
              Card(
                elevation: 1.0,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 5.0),
                child: Row(
                  children: [
                    Container(
                      child: IconButton(icon: Icon(Icons.local_phone_outlined, color: Colors.grey[500],), onPressed: (){}),
                    ),
                    Expanded(child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.friend.number),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text('Mobile',
                          style: TextStyle(
                            color: Colors.grey
                          ),),
                        ),
                      ],
                    ),),
                    Container(
                      child: IconButton(icon: Icon(Icons.message_outlined, color: Colors.grey[400],),
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
                          }),
                    )
                  ],
                ),
              )
            ]
          ))
        ],
      ),
    );
  }
}
