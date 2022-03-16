import 'package:flutter/material.dart';
import 'package:my_first_flutter_app/AddFriendForm.dart';
import 'package:my_first_flutter_app/DbHelper.dart';
import 'package:my_first_flutter_app/FriendsModel.dart';
import 'package:my_first_flutter_app/FriendsPage.dart';

class FriendsPage extends StatefulWidget {
  final int uid;
  FriendsPage(this.uid);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage>
    with SingleTickerProviderStateMixin {
  Future<List<Friend>> friends;
  bool isSearching = false;
  SQLiteDbProvider dbHelper;
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dbHelper = SQLiteDbProvider();
    friends = refreshFriendsList();
    refreshAfterAdd();
  }

  refreshFriendsList() {
    friends = dbHelper.getAllFriendsSpecificToUser(widget.uid);
    setState(() {});
  }

  refreshAfterAdd() {
    setState(() {});
  }

  Widget searchFriendsList(){
    return new FutureBuilder<List<Friend>>(
      future: dbHelper.getFriendByFriendsName(widget.uid, searchController.text),
      builder: (context, friends) {
        if (friends.hasData) {
          return new ListView.builder(
              padding:
              EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
              itemCount: friends.data.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => FriendPage(friends.data[index])));
                  },
                  child: new Card(
                    color: Colors.white,
                    margin: new EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    shape: new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0.0,
                    child: new Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        friends.data[index].image.isNotEmpty
                            ? Stack(children: [
                          new CircleAvatar(
                            backgroundImage: new AssetImage(
                                'asset/' +
                                    friends.data[index].image),
                            radius: 20.0,
                          ),
                          Positioned(
                            right: -2,
                            bottom: -3,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              child: Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          )
                        ])
                            : Stack(children: [
                          new CircleAvatar(
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.orange,
                              ),
                              child: Center(
                                child: Text(
                                  friends.data[index].name
                                      .substring(0, 1)
                                      .toUpperCase(),
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                            radius: 20.0,
                          ),
                          Positioned(
                            right: -1,
                            bottom: -2,
                            child: Container(
                              height: 16,
                              width: 16,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius:
                                  BorderRadius.circular(16)),
                              child: Icon(
                                Icons.message,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                          ),
                        ]),
                        new SizedBox(
                          width: 8.0,
                        ),
                        new Expanded(
                          child: new Text(
                            friends.data[index].name,
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        }
        return new Center(
          child: new CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'Friends Page',
          style: TextStyle(),
        ),
        centerTitle: true,
        elevation: 0.0,
        backgroundColor: Colors.grey[900],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddFriend(widget.uid)));
        },
        isExtended: true,
        backgroundColor: Colors.grey[900],
        child: Icon(
          Icons.add,
          size: 25,
          color: Colors.white,
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverList(
              delegate: SliverChildListDelegate([
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                isSearching == true
                    ? Padding(
                      padding: const EdgeInsets.fromLTRB(8.0, 0.0, 2.0, 0.0),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            isSearching = false;
                          });
                        },
                          child: Icon(Icons.arrow_back)),
                    )
                    : Container(),
                Expanded(
                  child: Container(
                    margin: EdgeInsets.symmetric(
                      vertical: 10, horizontal: 5.0
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      border: Border.all(
                          color: Colors.black87,
                          width: 1.0,
                          style: BorderStyle.solid),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    height: 40,
                    //width: MediaQuery.of(context).size.width,
                    child: Row(mainAxisSize: MainAxisSize.min, children: [
                      Expanded(
                          child: TextField(
                            onTap: () {},
                            controller: searchController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Search',
                            ),
                          )),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSearching = true;
                          });
                        },
                        child: Icon(Icons.search),
                      ),
                    ]),
                  ),
                ),
              ],
            )
          ])),
          SliverFillRemaining(
            child: isSearching != true? new FutureBuilder<List<Friend>>(
              future: dbHelper.getAllFriendsSpecificToUser(widget.uid),
              builder: (context, friends) {
                if (friends.hasData) {
                  return new ListView.builder(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      itemCount: friends.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => FriendPage(friends.data[index])));
                          },
                          child: new Card(
                            color: Colors.white,
                            margin: new EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                            elevation: 0.0,
                            child: new Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                friends.data[index].image.isNotEmpty
                                    ? Stack(children: [
                                        new CircleAvatar(
                                          backgroundImage: new AssetImage(
                                              'asset/' +
                                                  friends.data[index].image),
                                          radius: 20.0,
                                        ),
                                        Positioned(
                                          right: -2,
                                          bottom: -3,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Icon(
                                              Icons.message,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        )
                                      ])
                                    : Stack(children: [
                                        new CircleAvatar(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: Colors.orange,
                                            ),
                                            child: Center(
                                              child: Text(
                                                friends.data[index].name
                                                    .substring(0, 1)
                                                    .toUpperCase(),
                                                style: TextStyle(
                                                  fontSize: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                          radius: 20.0,
                                        ),
                                        Positioned(
                                          right: -1,
                                          bottom: -2,
                                          child: Container(
                                            height: 16,
                                            width: 16,
                                            decoration: BoxDecoration(
                                                color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(16)),
                                            child: Icon(
                                              Icons.message,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ]),
                                new SizedBox(
                                  width: 8.0,
                                ),
                                new Expanded(
                                  child: new Text(
                                    friends.data[index].name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w400),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      });
                }
                return new Center(
                  child: new CircularProgressIndicator(),
                );
              },
            )
            : searchFriendsList(),
          ),
        ],
      ),
    );
  }
}
