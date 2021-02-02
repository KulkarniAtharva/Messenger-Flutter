import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'file:///D:/Downloads/messenger_flutter/lib/models/chat_model.dart';
import 'file:///D:/Downloads/messenger_flutter/lib/views/chat_screen.dart';

class Home extends StatefulWidget
{
  Home({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home>
{
  int _currentIndex = 0;
  PageController _pageController;

  // List<StoryModel> stories = new List();
  List<ChatModel> chats = new List();
  ChatModel chatModel = new ChatModel();

  @override
  void initState()
  {
    super.initState();
    _pageController = PageController();

    // stories = getStories();
    chats = getChats();
  }

  List<ChatModel> getChats()
  {
    //1
    chatModel.name = "Atharva Kulkarni";
    chatModel.imgUrl ="https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60";
    chatModel.lastMessage ="Oh hey there, Sanskar. I'm all good btw. How are you?";
    chatModel.lastSeenTime = "5m";
    chatModel.haveunreadmessages = true;
    chatModel.unreadmessages = 1;
    chats.add(chatModel);

    chatModel = new ChatModel();

    //1
    chatModel.name = "Adwait Gondhalekar";
    chatModel.imgUrl = "https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=934&q=80";
    chatModel.lastMessage = "how are you, lets catch up";
    chatModel.lastSeenTime = "5 m";
    chatModel.haveunreadmessages = false;
    chatModel.unreadmessages = 1;
    chats.add(chatModel);

    chatModel = new ChatModel();

    //1
    chatModel.name = "Virat Kohli";
    chatModel.imgUrl = "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60";
    chatModel.lastMessage = "Oh hey there, Sanskar. I'm all good btw. How are you?";
    chatModel.lastSeenTime = "1 hr";
    chatModel.haveunreadmessages = false;
    chatModel.unreadmessages = 1;
    chats.add(chatModel);

    return chats;
  }

  @override
  void dispose()
  {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(title: Text("Messenger")),
      body: SizedBox.expand(
        child: PageView(
          controller: _pageController,
          onPageChanged: (index)
          {
            setState(() => _currentIndex = index);
          },
          children: <Widget>[
            Container(
            ),
            Container(
                padding: EdgeInsets.symmetric(horizontal: 24),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30),
                        topRight: Radius.circular(30))),
                child: Column(
                  children: <Widget>[
                    ListView.builder(
                        itemCount: chats.length,
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemBuilder: (context, index)
                        {
                          return ChatTile(
                            imgUrl: chats[index].imgUrl,
                            name: chats[index].name,
                            lastMessage: chats[index].lastMessage,
                            haveunreadmessages: chats[index].haveunreadmessages,
                            unreadmessages: chats[index].unreadmessages,
                            lastSeenTime: chats[index].lastSeenTime,
                          );
                        }),
                  ],
                )
            ),
            Container(color: Colors.red,),
            Container(color: Colors.green,),
            Container(color: Colors.blue,),
          ],
        ),
      ),

      bottomNavigationBar: BottomNavyBar(
        selectedIndex: _currentIndex,
        onItemSelected: (index)
        {
          setState(() => _currentIndex = index);
          _pageController.jumpToPage(index);
        },
        items: <BottomNavyBarItem>[
          BottomNavyBarItem(
              title: Text('Home  '),
              icon: Icon(Icons.home)
          ),
          BottomNavyBarItem(
              title: Text('Chats'),
              icon: Icon(Icons.chat)
          ),
          BottomNavyBarItem(
              title: Text('Search User'),
              icon: Icon(Icons.search)
          ),
          BottomNavyBarItem(
              title: Text('Calls'),
              icon: Icon(Icons.call_sharp)
          ),
          BottomNavyBarItem(
              title: Text('Settings'),
              icon: Icon(Icons.settings)
          ),
        ],
      ),
    );
  }
}

class ChatTile extends StatelessWidget
{
  final String imgUrl;
  final String name;
  final String lastMessage;
  final bool haveunreadmessages;
  final int unreadmessages;
  final String lastSeenTime;
  ChatTile(
      {@required this.unreadmessages,
        @required this.haveunreadmessages,
        @required this.lastSeenTime,
        @required this.lastMessage,
        @required this.imgUrl,
        @required this.name});
  @override
  Widget build(BuildContext context)
  {
    return GestureDetector(
      onTap: ()
      {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ChatScreen()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 16),
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(60),
              child: Image.network(
                imgUrl,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              width: 16,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    name,
                    style: TextStyle(
                        color: Colors.black87,
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    lastMessage,
                    style: TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontFamily: "Neue Haas Grotesk"),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 14,
            ),
            Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text(lastSeenTime),
                  SizedBox(
                    height: 16,
                  ),
                  haveunreadmessages
                      ? Container(
                      width: 30,
                      height: 30,
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Color(0xffff410f),
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "$unreadmessages",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ))
                      : Container()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}