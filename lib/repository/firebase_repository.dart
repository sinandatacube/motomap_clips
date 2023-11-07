import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:motomap_clips/models/chat_model.dart';

class FirebaseRepository {
  final CollectionReference firestore =
      FirebaseFirestore.instance.collection('conversations');
  // CollectionReference itemsCollection = firestore.collection('conversations');
  fetchchatMembers(String userId) async* {
    try {
      List chats = [];
      QuerySnapshot querySnapshot =
          // await FirebaseFirestore.instance.collection('conversations').get();
          await firestore.get();

      if (querySnapshot.docs.isNotEmpty) {
        log(querySnapshot.docs.toString(), name: "documentSnapshot docs");

        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          // Access data fields using documentSnapshot.data().

          log(documentSnapshot.data().toString(), name: "documentSnapshot");

          // if(userId==)
          Map<dynamic, dynamic> data = documentSnapshot.data() as Map;

          ChatModel chat = ChatModel.fromJson(data);
          log(chat.users.reciever.toString(), name: "chars");

          if (chat.users.reciever == userId || chat.users.sender == userId) {
            chats.add({'chats': chat, 'id': documentSnapshot.id});
          }
        }

        yield chats;
      } else {
        print('No documents found in the collection.');
        yield chats;
      }
    } catch (e) {
      print('Error retrieving data: $e');
    }
  }

  ////////////////////////////////////////////////////////////////////
  fetchChats(String chatId) async* {
    log(chatId);
    var querySnapshot =
        // FirebaseFirestore.instance
        //     .collection('conversations')
        firestore.doc(chatId).snapshots();
    log(querySnapshot.toString(), name: "asddfdfgd");
    yield querySnapshot;
    // Map<String, dynamic> data = querySnapshot.;
  }

  sendMessageToDatabsse(Message msg, String docId) async {
    Map status = {};
    try {
      DocumentReference documentRef =
          // FirebaseFirestore.instance.collection('conversations')
          firestore.doc(docId);

      documentRef.update({
        'latestTime': Timestamp.now(),
        'messages': FieldValue.arrayUnion([msg.toJson()])
      });
      status = {"status": "success"};
      return status;
    } catch (e) {
      log(e.toString(), name: "asdfg");
      return status = {"status": "failed"};
    }
  }

  checkChatExist(
      {required senderId,
      required recieverId,
      required adId,
      required vehicleType}) async {
    Map status = {
      'status': "not exist",
    };
    try {
      String docId;

      QuerySnapshot querySnapshot = await
          // FirebaseFirestore.instance.collection('conversations')
          firestore.get();

      if (querySnapshot.docs.isNotEmpty) {
        log(querySnapshot.docs.toString(), name: "documentSnapshot docs");

        for (DocumentSnapshot documentSnapshot in querySnapshot.docs) {
          // Access data fields using documentSnapshot.data().

          log(documentSnapshot.data().toString(), name: "documentSnapshot");

          // if(userId==)
          Map<dynamic, dynamic> data = documentSnapshot.data() as Map;

          ChatModel chat = ChatModel.fromJson(data);
          debugPrint(chat.users.reciever.toString() + " chars");

          if (chat.users.reciever == recieverId &&
              chat.users.sender == senderId &&
              chat.users.vehicleId == adId &&
              chat.users.vehicleType.toLowerCase() ==
                  vehicleType.toLowerCase()) {
            // chats.add({'chats': chat, 'id': documentSnapshot.id});
            docId = documentSnapshot.id;
            status = {'status': "exist", 'docId': docId, 'chats': chat};
          }
        }
        return status;
      } else {
        print('No documents found in the collection.');
        return status;
      }
    } catch (e) {
      debugPrint(e.toString());
      status = {"status": "error", "error": "client error"};
      return status;
    }
  }

  createConversation(
      {required senderId,
      required recieverId,
      required senderType,
      required recieverType,
      required recieverName,
      required vehicleName,
      required vehicleFrom,
      required vehicleId,
      required vehicleType,
      required senderName}) async {
    // final FirebaseFirestore firestore = FirebaseFirestore.instance;
    try {
      log("create");
      // CollectionReference itemsCollection =
      //     firestore.collection('conversations');
      ChatModel newConversation = ChatModel(
          latestTime: Timestamp.now(),
          messages: [],
          users: Users(
              sender: senderId,
              reciever: recieverId,
              recieverName: recieverName,
              senderName: senderName,
              recieverType: recieverType,
              vehicleFrom: vehicleFrom,
              vehicleId: vehicleId,
              vehicleType: vehicleType,
              vehicleName: vehicleName,
              createdDate: Timestamp.now(),
              senderType: senderType));
      DocumentReference<Object?> res =
          // await itemsCollection.add(newConversation.toJson());
          await firestore.add(newConversation.toJson());

      log("docIddsaf");

      if (res.id.isNotEmpty) {
        log("docIddsafsadasd");

        String docId = res.id;
        log(docId);
        return {'status': 'success', 'docId': docId};
      } else {
        return {
          'status': 'failed',
          'error': "new conversation creation failed"
        };
      }
    } catch (e) {
      log(e.toString());
      return {'status': 'failed', 'error': "client side error $e"};
    }
  }
}
