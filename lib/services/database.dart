import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class DatabaseMethods
{
  Future<void> addData(userData) async
  {
    FirebaseFirestore.instance.collection("users").add(userData).catchError((e)
    {
      print(e);
    });
  }

  getData() async
  {
    return FirebaseFirestore.instance.collection("users").snapshots();
  }

  getUserInfo(String email) async
  {
    return FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }

  Future<QuerySnapshot> getRecentUsers() async
  {
    return await FirebaseFirestore.instance.collection("users").limit(10).get();
  }

  Future<bool> addChatRoom(chatRoom, String chatRoomId) async
  {
    QuerySnapshot blockedSnapshot = await isUserBlocked(chatRoomId);
    print("${blockedSnapshot.toString()} this what we have");
    if (blockedSnapshot.docs.length == 0)
    {
      FirebaseFirestore.instance
          .collection("chatRooms")
          .doc(chatRoomId)
          .set(chatRoom)
          .catchError((e)
      {
        print(e);
      });
      return true;
    }
    else
    {
      print("cannot send message");
      return false;
    }
  }

  Future<void> removeChatRoom(String chatRoomId) async
  {
    FirebaseFirestore.instance.collection("chatRooms").doc(chatRoomId).delete();
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .get()
        .then((snapshot)
    {
      for (DocumentSnapshot doc in snapshot.docs)
      {
        doc.reference.delete();
      }
    });
  }

  removeChat({String chatRoomId, String chatId})
  {
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(chatId)
        .delete();
  }

  getChats(String chatRoomId) async
  {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .orderBy('time')
        .snapshots();
  }

  Future<void> addMessage(String chatRoomId, messageData, String messageId, chatRoomUpdate) async
  {
    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .set(chatRoomUpdate)
        .catchError((e)
    {
      print(e);
    });

    FirebaseFirestore.instance
        .collection("chatRooms")
        .doc(chatRoomId)
        .collection("chats")
        .doc(messageId)
        .set(messageData)
        .catchError((e)
    {
      print(e + "ho  ku nahi raha be");
    });
  }

  Future<void> blockUser({@required String userName, @required blockInfo})
  {
    return FirebaseFirestore.instance.collection("blockInfo").add(blockInfo);
  }

  Future<QuerySnapshot> isUserBlocked(String chatId)
  {
    print("this is the id we are checking at is UserBlocked + $chatId");
    return FirebaseFirestore.instance
        .collection("blockInfo")
        .where('id', isEqualTo: chatId)
        .get();
  }

  getUserChats(String itIsMyName) async
  {
    return FirebaseFirestore.instance
        .collection("chatRooms")
        .where('users', arrayContains: itIsMyName)
        .snapshots();
  }

  CollectionReference services = FirebaseFirestore.instance.collection('services');

  Future<void> addService()
  {
    // Call the user's CollectionReference to add a new user
    return services
        .add({
      'Image': '_uploadedImageURL.toString()',
      'Title': 'title', // John Doe
      'Price': 'price', // Stokes and Sons
      'Description': 'product_desc',
      'Dates': 'working_dates',
      'Duration': 'slot_duration',
      'About': 'about',
    })
        .then((value) => print("Service Added"))
        .catchError((error) =>
    {
      print("Failed to add user: $error"),
      /*setState(()
      {
        data_flag = 1;
      })*/
    });
  }

}