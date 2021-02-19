import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:messenger_flutter/services/database.dart';
import 'package:messenger_flutter/views/chat_screen.dart';
import 'package:quiver/time.dart';

const double chatBarMargin = 4;
const double chatBarRadius = 12;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

DatabaseMethods databaseMethods = DatabaseMethods();

class ChatBarItem
{
  final IconData icon;
  final VoidCallback onPressed;

  ChatBarItem(this.icon, this.onPressed);
}

class ChatBar extends StatefulWidget
{
  @override
  _ChatBarState createState() => _ChatBarState();
}

class _ChatBarState extends State<ChatBar> with TickerProviderStateMixin
{
  List<ChatBarItem> _chatBarItems = [
    ChatBarItem(Icons.mic, () => print('record')),
    ChatBarItem(Icons.camera_alt, () => print('picture')),
    ChatBarItem(Icons.videocam, () => print('video')),
  ];

  AnimationController _elasticAnimationController;
  AnimationController _bounceAnimationController;
  CurvedAnimation _elasticAnimation, _bounceAnimation;
  TextEditingController _messageController = TextEditingController();

  bool _showMediaButtons = false;

  @override
  void initState()
  {
    super.initState();

    _elasticAnimationController = AnimationController(vsync: this, duration: aSecond * .2)..addListener(_update);
    _bounceAnimationController = AnimationController(vsync: this, duration: aSecond * .1)..addListener(_update);

    _elasticAnimation = CurvedAnimation(parent: _elasticAnimationController, curve: Curves.decelerate);
    _bounceAnimation = CurvedAnimation(
        parent: _bounceAnimationController,
        curve: Curves.elasticInOut,
        reverseCurve: Curves.elasticInOut);
  }

  @override
  void dispose()
  {
    super.dispose();
    _elasticAnimationController.removeListener(_update);
    _bounceAnimationController.removeListener(_update);
  }

  void _update() => setState(() {});

  @override
  Widget build(BuildContext context)
  {
    final _media = MediaQuery.of(context).size.shortestSide;

    return Padding(
      padding: const EdgeInsets.only(bottom: chatBarMargin),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(chatBarRadius),
        child: Stack(
          children: <Widget>[
            _buildBarBackground(),
            _buildMainButton(),
            Container(
              child: _buildMessageField(),
              width: _media < 375 ? 310 : 360,
            ),
            _buildMediaButtons(),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Positioned _buildBarBackground()
  {
    return Positioned.fill(
        left: chatBarMargin,
        right: chatBarMargin,
        child: Transform.rotate(
          angle: _bounceAnimation.value * (pi / (_showMediaButtons ? -52 : 52)),
          alignment: Alignment.centerLeft,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(chatBarRadius),
                color: Colors.cyan.shade600),
          ),
        ));
  }

  Positioned _buildMainButton()
  {
    return Positioned(
      left: chatBarMargin,
      top: 8,
      child: Transform.rotate(
        angle: -pi / 4 * _elasticAnimation.value,
        child: _buildCircleButton(ChatBarItem(Icons.add, _chooseMedia)),
      ),
    );
  }

  Positioned _buildSendButton()
  {
    return Positioned(
      right: chatBarMargin,
      top: 8,
      child: Transform.translate(
        offset: Offset(100 * _elasticAnimation.value, 0),
        child: Opacity(
          opacity: min(max(0, 1 - _elasticAnimation.value), 1),
          child: _buildCircleButton(
            ChatBarItem(Icons.send, _sendMessage),
          ),
        ),
      ),
    );
  }

  Opacity _buildMessageField()
  {
    return Opacity(
      opacity: min(max(0, 1 - _elasticAnimation.value), 1),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 72.0,
          top: 10,
          bottom: 8,
          right: chatBarMargin * 3,
        ),
        child: Transform.rotate(
          child: TextFormField(
            textInputAction: TextInputAction.send,
            controller: _messageController,
            enabled: !_showMediaButtons,
            style: TextStyle(
                color: Colors.white),
            cursorColor: Colors.white,
            onFieldSubmitted: (s)
            {


              print(s);
              _messageController.clear();
            },
            decoration: InputDecoration(
              labelText: 'Message...',
              labelStyle: TextStyle(color: Colors.white),
              hasFloatingPlaceholder: false,
              border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(chatBarRadius - 2)),
              enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(chatBarRadius - 2)),
              filled: true,
              fillColor: Colors.white30,
            ),
          ),
          alignment: Alignment.centerLeft,
          angle: (-pi / 2) * _elasticAnimation.value,
        ),
      ),
    );
  }

  Opacity _buildMediaButtons()
  {
    return Opacity(
      opacity: min(max(0, _elasticAnimation.value), 1),
      child: Padding(
        padding: const EdgeInsets.only(
          left: 78.0,
          top: 8,
          bottom: 8,
          right: 20,
        ),
        child: Transform.rotate(
          angle: (pi / 2) * (1 - _elasticAnimation.value),
          child: Row(
            children:
            _chatBarItems.map((item) => _buildCircleButton(item)).toList(),
          ),
          alignment: Alignment.centerLeft,
          origin: Offset(-10, 10),
        ),
      ),
    );
  }

  Widget _buildCircleButton(ChatBarItem item)
  {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration:
        BoxDecoration(shape: BoxShape.circle, color: Colors.white30),
        child: IconButton(
            highlightColor: Colors.yellowAccent,
            splashColor: Colors.yellowAccent,
            icon: Icon(item.icon, color: Colors.white),
            onPressed: item.onPressed),
      ),
    );
  }

  void _chooseMedia()
  {
    if (_elasticAnimationController.status == AnimationStatus.dismissed)
      _elasticAnimationController.forward();
    else if (_elasticAnimationController.status == AnimationStatus.completed)
      _elasticAnimationController.reverse();

    Future.delayed(aSecond * .4, ()
    {
      _bounceAnimationController
        ..forward()
        ..addStatusListener((status)
        {
          if (status == AnimationStatus.completed)
            _bounceAnimationController.reverse();
        });
      _showMediaButtons = !_showMediaButtons;
      _update();
    });
  }

  void _sendMessage()
  {
    if(_messageController.text != null)
    {
      print(_messageController.text+"dff");

     /* _firestore.collection('Atharva2204').doc('person').collection('Adwait7122').doc().set({
        'from': 'Atharva2204',
        'text':_messageController.text,
        'time':DateTime.now().millisecondsSinceEpoch,
        'date': DateTime.now().microsecondsSinceEpoch
      });*/


      /*firestore.collection("users").add(
          {
            "name" : "john",
            "age" : 50,
            "email" : "example@example.com",
            "address" :
            {
              "street" : "street 24",
              "city" : "new york"
            }
          }).
      then((value)
      {
        print(value.id);
      });*/

      databaseMethods.addService();

      _messageController.clear();
    }
  }
}