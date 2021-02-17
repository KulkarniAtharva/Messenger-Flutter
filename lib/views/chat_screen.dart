import 'package:flutter/material.dart';
import 'package:messenger_flutter/chat_bar.dart';
import 'package:messenger_flutter/data/data.dart';
import 'package:messenger_flutter/models/message_model.dart';


class ChatScreen extends StatefulWidget
{
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
{
  List<MessageModel> messages = new List();
  FocusNode myFocusNode;

  String value = "";

  @override
  void initState()
  {
   // super.initState();
   // messages = getMessages();
    myFocusNode = FocusNode();
  }

  @override
  void dispose()
  {
    myFocusNode.dispose();
   // super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 30,),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 12,vertical: 15),
              color: Color(0xffff410f),
              child: Row(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: Image.network(
                      "https://images.unsplash.com/photo-1521572267360-ee0c2909d518?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=1000&q=60",
                      height: 45,
                      width: 45,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(
                    width: 14,
                  ),
                  Column(
                      children: <Widget>[
                        Text(
                          "Atharva Kulkarni",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text("5 minutes ago",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w300),),
                      ]),
                  SizedBox(
                    width: 150,
                  ),
                  Icon(Icons.more_vert,
                      color: Colors.white),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: ListView.builder(
                  itemCount: messages.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index)
                  {
                    return ChattingTile(
                      isByMe: messages[index].isByme,
                      message: messages[index].message,
                    );
                  }),
            ),
            new Expanded(
                child: new Align(
                    alignment: Alignment.bottomCenter,
                    child: ChatBar()))
          ],
        ),
      ),
      /*bottomSheet: Container(
        child: ChatBar(),
        /*padding: EdgeInsets.symmetric(horizontal: 16, vertical: 30),
        width: MediaQuery.of(context).size.width,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          decoration: BoxDecoration(
              color: Color(0xffF4F5FA),
              borderRadius: BorderRadius.circular(30)),
          child: Row(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7ef),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.asset(
                  "assets/images/more.png",
                  width: 30,
                  height: 30,
                ),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                child: TextField(
                  focusNode: myFocusNode,

                  textInputAction: TextInputAction.send,
                  decoration: InputDecoration.collapsed(
                      hintText: "Aa",
                      hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                  onChanged: (v) {
                    //do something
                    myFocusNode.requestFocus();
                  },

                ),
              ),
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Color(0xffe7e7ef),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Image.asset(
                  "assets/images/smile.png",
                  width: 30,
                  height: 30,
                ),
              ),
            ],
          ),
        ),*/
      ),*/
    );
  }
}

class ChattingTile extends StatelessWidget
{
  final bool isByMe;
  final String message;
  ChattingTile({@required this.isByMe, @required this.message});

  @override
  Widget build(BuildContext context)
  {
    print(message+" ask");

    return Container(
      margin: EdgeInsets.only(bottom: 24),
      alignment: isByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        decoration: BoxDecoration(
            color: isByMe ? Color(0xffff410f) : Color(0xfffff3f1),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
                bottomLeft: isByMe ? Radius.circular(30) : Radius.circular(0),
                bottomRight: isByMe ? Radius.circular(0) : Radius.circular(30))),
        padding: EdgeInsets.symmetric(vertical: 11, horizontal: 20),
        child: Container(
          constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 2 / 3),
          child: Text(
            message,
            style: TextStyle(
                color: isByMe ? Colors.white : Color(0xff650000),
                fontSize: 14,
                fontWeight: FontWeight.w500),
          ),
        ),
      ),
    );
  }
}