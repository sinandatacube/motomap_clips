// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:motomap_clips/logic/chats/chat_cubit.dart';


// class ReelChat extends StatefulWidget {
//   final String vehicleName;
//   final String vehicleFrom;
//   final String adId;
//   final String vehicleType;
//   final String dealerId;
//   final String dealerName;
//   final String recieverType;
//   final String senderId;
//   final String senderName;
//   final String senderType;
//   final String customerName;
//   final String customerId;

//   const ReelChat(
//       {super.key,
//       required this.adId,
//       required this.dealerId,
//       required this.dealerName,
//       required this.recieverType,
//       required this.senderId,
//       required this.senderName,
//       required this.senderType,
//       required this.vehicleFrom,
//       required this.vehicleName,
//       required this.customerName,
//       required this.customerId,
//       required this.vehicleType});

//   @override
//   State<ReelChat> createState() => _ReelChatState();
// }

// class _ReelChatState extends State<ReelChat> {
//   // var user = HiveHelpers().getCredentials();
//   @override
//   void initState() {
//     context.read<ChatCubit>().chatwithShowroom(
//         vehicleName: widget.vehicleName,
//         vehicleFrom: widget.vehicleFrom,
//         vehicleId: widget.adId,
//         vehicleType: widget.vehicleType,
//         recieverId: widget.dealerId,
//         recieverName: widget.dealerName,
//         recieverType: widget.recieverType,
//         senderId:widget.customerId,
//         senderName: widget.customerName,
//         senderType: widget.senderType);
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.transparent,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         automaticallyImplyLeading: false,
//       ),
//       body: BlocConsumer<ChatCubit, ChatState>(
//         listener: (context, state1) {
//           debugPrint(state1.toString() + "asd");
//           if (state1 is ShowroomChatExist) {
//            Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (_) => ChatView(
//                       chats: state1.chats,
//                       chatId: state1.docId,
//                     )));
//           }

//           if (state1 is ShowroomChatError) {
//           Navigator.of(context).pop();
//             Fluttertoast.cancel();
//             Fluttertoast.showToast(msg: "something went wrong");
//           }
//           if (state1 is ShowroomNewChat) {
//             // TODO
//           Navigator.of(context).pushReplacement(MaterialPageRoute(
//                 builder: (_) => ShowroomChatView(
//                       docId: state1.docId,
//                       recieverId: state1.recieverId,
//                       senderId: state1.senderId,
//                       showroomName: state1.showroomName,
//                       recieverName: state1.showroomName,
//                       senderName:widget. customerName ?? "",
//                       vehicleFrom: widget.vehicleFrom,
//                       vehicleId: widget.adId,
//                       vehicleType: widget.vehicleType,
//                       vehicleName: widget.vehicleName,
//                     )));
//           }
//         },
//         builder: (context, state) {
//           debugPrint(state.toString() + "asd");

//           if (state is ShowroomChatLoading) {
//             return const Center(
//               child: CupertinoActivityIndicator(
//                 radius: 10,
//                 color: Colors.white,
//               ),
//             );
//           }

//           return TextButton(
//             onPressed: () {
//               if (widget.customerId != null && widget.customerName!= null) {
//                 // navigatorKey.currentState?.push(MaterialPageRoute(
//                 //     builder: (_) => ReelChat(
//                 //           adId: widget.reelItem.adId,
//                 //           dealerId: widget.reelItem.dealerId,
//                 //           dealerName: widget.reelItem.dealerName,
//                 //           recieverType: "showroom",
//                 //           senderId: user!.userId,
//                 //           senderName: user!.name,
//                 //           senderType: "customer",
//                 //           vehicleFrom: widget.reelItem.vehicleFrom,
//                 //           vehicleName: widget.reelItem.vehicleName,
//                 //           vehicleType: widget.reelItem.vehicleType,
//                 //         )));
//               } else {
//                 Fluttertoast.cancel();
//                 Fluttertoast.showToast(msg: "Something went Wrong");
//               }
//             },
//             child: const Column(
//               children: [
//                 Icon(
//                   CupertinoIcons.chat_bubble,
//                   size: 20,
//                   color: Colors.white,
//                 ),
//                 Text(
//                   "Chat",
//                   style: TextStyle(fontSize: 10, color: Colors.white),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
