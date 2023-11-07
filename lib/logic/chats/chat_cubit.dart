// import 'dart:developer';

// import 'package:bloc/bloc.dart';
// import 'package:motomap_clips/models/chat_model.dart';
// import 'package:motomap_clips/repository/firebase_repository.dart';

// part 'chat_state.dart';

// class ChatCubit extends Cubit<ChatState> {
//   final InternetRepository internetRepository;
//   final FirebaseRepository firebaseRepository;

//   ChatCubit(
//       {required this.internetRepository, required this.firebaseRepository})
//       : super(ChatInitial());

//   // chatsLoad() async {
//   //   try {
//   //     emit(ChatLoading());
//   //     bool isConnected = await internetRepository.connectionCheck();
//   //     if (isConnected) {
//   //       var res = await FirebaseRepository().fetchchatMembers("32");
//   //       log(res.toString(), name: "chats load");
//   //       emit(ChatLoaded(chats: res));
//   //     } else {
//   //       emit(ChatNoNetwork());
//   //     }
//   //   } catch (e) {
//   //     log(e.toString(), name: "chats error");

//   //     emit(ChatError());
//   //   }
//   // }
//   initShowroomChat() {
//     emit(ShowroomChatInit());
//   }

//   chatwithShowroom(
//       {required senderId,
//       required recieverId,
//       required senderType,
//       required recieverType,
//       required recieverName,
//       required vehicleFrom,
//       required vehicleId,
//       required vehicleName,
//       required vehicleType,
//       required senderName}) async {
//     try {
//       emit(ShowroomChatLoading());
//       debugPrint("sadsSD.toString()" + "resp0");

//       var response = await firebaseRepository.checkChatExist(
//           recieverId: recieverId,
//           senderId: senderId,
//           adId: vehicleId,
//           vehicleType: vehicleType);
//       debugPrint(response.toString() + " resp1");

//       if (response['status'] == 'exist') {
//         debugPrint(response.toString() + " rsponse 2313");
//         debugPrint("chat existtttttttttttttttt");

//         emit(ShowroomChatExist(
//             docId: response['docId'], chats: response['chats']));
//       } else if (response['status'] == 'not exist') {
//         var res = await firebaseRepository.createConversation(
//             vehicleName: vehicleName,
//             senderId: senderId,
//             recieverId: recieverId,
//             recieverName: recieverName,
//             recieverType: recieverType,
//             senderName: senderName,
//             vehicleFrom: vehicleFrom,
//             vehicleId: vehicleId,
//             vehicleType: vehicleType,
//             senderType: senderType);
//         debugPrint(res.toString() + " resp2");
//         if (res['status'] == 'success') {
//           emit(ShowroomNewChat(
//               docId: res['docId'],
//               recieverId: recieverId,
//               senderId: senderId,
//               showroomName: recieverName));
//         } else {
//           debugPrint(res['error'] + " showroom chat error");
//           emit(ShowroomChatError());
//         }
//       }

//       // else if (response['status'] == 'not exist') {
//       //   var res = await FirebaseRepository().createConversation(
//       //       senderId: senderId,
//       //       recieverId: recieverId,
//       //       recieverName: recieverName,
//       //       recieverType: recieverType,
//       //       senderName: senderName,
//       //       senderType: senderType);
//       // }

//       // FirebaseRepository().createConversation(
//       //     senderId: senderId,
//       //     recieverId: recieverId,
//       //     senderType: senderType,
//       //     recieverType: recieverType,
//       //     recieverName: recieverName,
//       // senderName: senderName);
//     } catch (e) {
//       debugPrint(e.toString() + "chat existtttttttttttttttt");
//     }
//   }
// }
