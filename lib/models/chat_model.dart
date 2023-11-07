import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

ChatModel chatModelFromJson(String str) => ChatModel.fromJson(json.decode(str));

String chatModelToJson(ChatModel data) => json.encode(data.toJson());

class ChatModel {
  List<Message> messages;
  Users users;
  Timestamp latestTime;

  ChatModel({
    required this.messages,
    required this.users,
    required this.latestTime,
  });

  factory ChatModel.fromJson(Map<dynamic, dynamic> json) => ChatModel(
        latestTime: json["latestTime"] ?? Timestamp.now(),
        messages: List<Message>.from(
            json["messages"].map((x) => Message.fromJson(x))),
        users: Users.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "latestTime": Timestamp.now(),
        "messages": List<dynamic>.from(messages.map((x) => x.toJson())),
        "users": users.toJson(),
      };
}

class Message {
  Timestamp createdAt;
  String recieverId;
  String message;
  String senderId;
  bool isSeen;
  String recieverType;
  String senderType;

  Message({
    required this.createdAt,
    required this.recieverId,
    required this.message,
    required this.senderId,
    required this.isSeen,
    required this.recieverType,
    required this.senderType,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
        createdAt: json["created_at"],
        isSeen: json["is_seen"],
        recieverId: json["reciever_id"],
        message: json["message"],
        senderId: json["sender_id"],
        senderType: json["sender_type"],
        recieverType: json["reciever_type"],
      );

  Map<String, dynamic> toJson() => {
        "created_at": createdAt,
        "reciever_id": recieverId,
        "message": message,
        "sender_id": senderId,
        "is_seen": isSeen,
        "sender_type": senderType,
        "reciever_type": recieverType
      };
}

class Users {
  String sender;
  String senderName;
  String senderType;
  String reciever;
  String recieverName;
  String recieverType;
  String vehicleId;
  String vehicleFrom;
  String vehicleType;
  String vehicleName;

  Timestamp createdDate;

  Users({
    required this.sender,
    required this.reciever,
    required this.recieverName,
    required this.senderName,
    required this.recieverType,
    required this.senderType,
    required this.vehicleId,
    required this.vehicleFrom,
    required this.vehicleType,
    required this.createdDate,
    required this.vehicleName,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
      sender: json["sender_id"],
      reciever: json["reciever_id"],
      recieverName: json["reciever_name"],
      senderName: json["sender_name"],
      recieverType: json["reciever_type"],
      createdDate: json["created_date"],
      vehicleFrom: json["vehicle_from"],
      vehicleType: json["vehicle_type"],
      vehicleId: json["vehicle_id"],
      vehicleName: json["vehicle_name"],
      senderType: json["sender_type"]);

  Map<String, dynamic> toJson() => {
        "sender_id": sender,
        "reciever_id": reciever,
        "reciever_name": recieverName,
        "sender_name": senderName,
        "reciever_type": recieverType,
        "sender_type": senderType,
        "created_date": createdDate,
        "vehicle_from": vehicleFrom,
        "vehicle_id": vehicleId,
        "vehicle_type": vehicleType,
        "vehicle_name": vehicleName,
      };
}
