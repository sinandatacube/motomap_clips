import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:motomap_clips/logic/impression/impression_cubit.dart';

import 'package:motomap_clips/models/reel_model.dart';
import 'package:motomap_clips/views/interest_bottom_sheet.dart';
import 'package:motomap_clips/views/reels_chat.dart';
import 'package:motomap_clips/views/views.dart';
import 'package:video_player/video_player.dart';

class ScreenOptions extends StatefulWidget {
  final ReelModel reelItem;
  final int index;
  final String customerId;
  final String customerName;
  final String customerMobile;
  final VideoPlayerController videoController;

  const ScreenOptions(
      {super.key,
      required this.reelItem,
      required this.customerId,
      required this.customerName,
      required this.videoController,
      required this.customerMobile,
      required this.index});

  @override
  State<ScreenOptions> createState() => _ScreenOptionsState();
}

class _ScreenOptionsState extends State<ScreenOptions> {
  // var user = HiveHelpers().getCredentials();
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 110),
                    InkWell(
                      onTap: () {
                        widget.videoController.pause();
                        widget.reelItem.onDealerClick();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CachedNetworkImage(
                            imageUrl: widget.reelItem.dealerProfileUrl,
                            alignment: Alignment.centerLeft,
                            imageBuilder: (context, imageProvider) => Container(
                              height: 32,
                              width: 32,
                              padding: EdgeInsets.zero,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            placeholder: (context, url) => const SizedBox(
                              height: 32,
                              width: 32,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                                backgroundColor: Colors.white38,
                                strokeWidth: 1.5,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                const SizedBox(
                              height: 20,
                              width: 20,
                              child: Icon(Icons.error),
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            widget.reelItem.dealerName,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      // width: size.width * 0.4,
                      child: Text(
                        widget.reelItem.vehicleName,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      // width: size.width * 0.4,
                      child: Text(
                        widget.reelItem.vehicleYear,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      // width: size.width * 0.2,
                      child: Text(
                        widget.reelItem.adDescription,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
              Column(
                children: [
                  TextButton(
                    onPressed: () {
                      widget.videoController.pause();
                      if (widget.reelItem.isInterested == "1") {
                        showInterestRemovePopUp(
                          context,
                          size.width,
                          widget.reelItem.dealerId,
                          widget.reelItem.adId,
                          widget.reelItem.vehicleFrom,
                          widget.reelItem.vehicleType,
                          widget.customerId,
                          widget.customerMobile,
                          widget.index,
                        ).then((value) {
                          debugPrint(value.toString());
                          setState(() {});
                        });
                      } else {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return InterestBottomSheet(
                              customerId: widget.customerId,
                              customerMobile: widget.customerMobile,
                              customerName: widget.customerName,
                              isMotoClip: true,
                              index: widget.index,
                              id: widget.reelItem.adId,
                              showRoomId: widget.reelItem.dealerId,
                              type: widget.reelItem.vehicleType,
                              vehicleType: widget.reelItem.vehicleType,
                              vehicleFrom: widget.reelItem.vehicleFrom,
                            );
                          },
                        ).then((value) {
                          // reelsList[widget.index].isInterested = "1";
                          setState(() {});
                          widget.videoController.play();
                        });
                      }
                    },
                    child: Column(
                      children: [
                        // IconButton(
                        //   onPressed: () => reelItem.onInterestClick,
                        //   icon: const Icon(
                        //     Icons.thumb_up,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        Icon(
                          Icons.thumb_up,
                          size: 20,
                          color: widget.reelItem.isInterested == "1"
                              ? Colors.blue
                              : Colors.white,
                        ),
                        Text(
                          "Interest",
                          style: TextStyle(
                              fontSize: 10,
                              color: widget.reelItem.isInterested == "1"
                                  ? Colors.blue
                                  : Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  // IconButton(
                  //   onPressed: () => reelItem.onChatClick,
                  //   icon: const Icon(
                  //     Icons.comment,
                  //     color: Colors.white,
                  //   ),
                  // ),

                  // TextButton(
                  //   onPressed: () {
                  //     if (widget.customerId != null && widget.customerName != null) {
                  //       // context.read<ChatCubit>().chatwithShowroom(
                  //       //                             vehicleName: widget.reelItem.vehicleName,
                  //       //                             vehicleFrom: widget.reelItem.vehicleFrom,
                  //       //                             vehicleId: widget.reelItem.adId,
                  //       //                             vehicleType: widget.reelItem.vehicleType,
                  //       //                             recieverId: widget.reelItem.dealerId,
                  //       //                             recieverName: widget.reelItem.dealerName,
                  //       //                             recieverType: "showroom",
                  //       //                             senderId: user!.userId,
                  //       //                             senderName: user!.name,
                  //       //                             senderType: "customer");
                  //       debugPrint("asfdsfsa");
                  //       widget.videoController.pause();
                  //      Navigator.of(context).push(MaterialPageRoute(
                  //           builder: (_) => ReelChat(
                  //             customerId: widget.customerId,customerName: widget.customerName,
                  //                 adId: widget.reelItem.adId,
                  //                 dealerId: widget.reelItem.dealerId,
                  //                 dealerName: widget.reelItem.dealerName,
                  //                 recieverType: "showroom",
                  //                 senderId: widget.customerId,
                  //                 senderName:widget.customerName,
                  //                 senderType: "customer",
                  //                 vehicleFrom: widget.reelItem.vehicleFrom,
                  //                 vehicleName: widget.reelItem.vehicleName,
                  //                 vehicleType: widget.reelItem.vehicleType,
                  //               )));
                  //     } else {
                  //       Fluttertoast.cancel();
                  //       Fluttertoast.showToast(msg: "Something went Wrong");
                  //     }
                  //   },
                  //   child: const Column(
                  //     children: [
                  //       Icon(
                  //         CupertinoIcons.chat_bubble,
                  //         size: 20,
                  //         color: Colors.white,
                  //       ),
                  //       Text(
                  //         "Chat",
                  //         style: TextStyle(fontSize: 10, color: Colors.white),
                  //       )
                  //     ],
                  //   ),
                  // ),

                  // BlocConsumer<ChatCubit, ChatState>(
                  //   listener: (context, state1) {
                  //     if (state1 is ShowroomChatExist) {
                  //       navigatorKey.currentState?.push(MaterialPageRoute(
                  //           builder: (_) => ChatView(
                  //                 chats: state1.chats,
                  //                 chatId: state1.docId,
                  //               )));
                  //     }

                  //     if (state1 is ShowroomChatError) {
                  //       Fluttertoast.cancel();
                  //       Fluttertoast.showToast(msg: "something went wrong");
                  //     }
                  //     if (state1 is ShowroomNewChat) {
                  //       navigatorKey.currentState?.push(MaterialPageRoute(
                  //           builder: (_) => ShowroomChatView(
                  //                 docId: state1.docId,
                  //                 recieverId: state1.recieverId,
                  //                 senderId: state1.senderId,
                  //                 showroomName: state1.showroomName,
                  //                 recieverName: state1.showroomName,
                  //                 senderName: user?.name ?? "",
                  //                 vehicleFrom: widget.reelItem.vehicleFrom,
                  //                 vehicleId: widget.reelItem.adId,
                  //                 vehicleType: widget.reelItem.vehicleType,
                  //                 vehicleName: widget.reelItem.vehicleName,
                  //               )));
                  //     }
                  //   },
                  //   builder: (context, state) {
                  //     if (state is ShowroomChatLoading) {
                  //       return const CupertinoActivityIndicator(
                  //         radius: 10,
                  //         color: Colors.white,
                  //       );
                  //     }

                  //     return TextButton(
                  //       onPressed: () {
                  //         if (user?.userId != null && user?.name != null) {
                  //           // context.read<ChatCubit>().chatwithShowroom(
                  //           //                             vehicleName: widget.reelItem.vehicleName,
                  //           //                             vehicleFrom: widget.reelItem.vehicleFrom,
                  //           //                             vehicleId: widget.reelItem.adId,
                  //           //                             vehicleType: widget.reelItem.vehicleType,
                  //           //                             recieverId: widget.reelItem.dealerId,
                  //           //                             recieverName: widget.reelItem.dealerName,
                  //           //                             recieverType: "showroom",
                  //           //                             senderId: user!.userId,
                  //           //                             senderName: user!.name,
                  //           //                             senderType: "customer");
                  //           debugPrint("asfdsfsa");
                  //           navigatorKey.currentState?.push(MaterialPageRoute(
                  //               builder: (_) => ReelChat(
                  //                     adId: widget.reelItem.adId,
                  //                     dealerId: widget.reelItem.dealerId,
                  //                     dealerName: widget.reelItem.dealerName,
                  //                     recieverType: "showroom",
                  //                     senderId: user!.userId,
                  //                     senderName: user!.name,
                  //                     senderType: "customer",
                  //                     vehicleFrom: widget.reelItem.vehicleFrom,
                  //                     vehicleName: widget.reelItem.vehicleName,
                  //                     vehicleType: widget.reelItem.vehicleType,
                  //                   )));
                  //         } else {
                  //           Fluttertoast.cancel();
                  //           Fluttertoast.showToast(msg: "Something went Wrong");
                  //         }
                  //       },
                  //       child: const Column(
                  //         children: [
                  //           Icon(
                  //             CupertinoIcons.chat_bubble,
                  //             size: 20,
                  //             color: Colors.white,
                  //           ),
                  //           Text(
                  //             "Chat",
                  //             style:
                  //                 TextStyle(fontSize: 10, color: Colors.white),
                  //           )
                  //         ],
                  //       ),
                  //     );
                  //   },
                  // ),
                  const SizedBox(height: 25),

                  TextButton(
                    onPressed: () {
                      // print("object");
                      widget.videoController.pause();
                      widget.reelItem.onShareClick();
                    },
                    child: const Column(
                      children: [
                        // IconButton(
                        //   onPressed: () => reelItem.onInterestClick,
                        //   icon: const Icon(
                        //     Icons.thumb_up,
                        //     color: Colors.white,
                        //   ),
                        // ),
                        Icon(
                          Icons.share,
                          size: 20,
                          color: Colors.white,
                        ),
                        Text(
                          "Share",
                          style: TextStyle(fontSize: 10, color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),

                  // Column(
                  //   children: [
                  //     // IconButton(
                  //     //   onPressed: () => reelItem.onInterestClick,
                  //     //   icon: const Icon(
                  //     //     Icons.thumb_up,
                  //     //     color: Colors.white,
                  //     //   ),
                  //     // ),
                  //     const Icon(
                  //       Icons.remove_red_eye_outlined,
                  //       size: 20,
                  //       color: Colors.white,
                  //     ),
                  //     Text(
                  //       widget.reelItem.viewCount,
                  //       style:
                  //           const TextStyle(fontSize: 10, color: Colors.white),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(height: 60),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<dynamic> showInterestRemovePopUp(
      BuildContext context2,
      double width,
      String showroomID,
      String adId,
      String vehicleFrom,
      String type,
      String customerId,
      String customerMobile,
      int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.red,
                    elevation: 0,
                    // backgroundColor: Colors.black
                  ),
                  onPressed: () {
                    widget.videoController.play();

                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "Cancel",
                    textScaleFactor: 0.9,
                  )),
              BlocConsumer<ImpressionCubit, ImpressionState>(
                listener: (context, state) {
                  if (state is ImpressionError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.error),
                        margin: const EdgeInsets.all(5),
                        behavior: SnackBarBehavior.floating,
                      ),
                    );
                  }
                  if (state is ImpressionRemoved) {
                    reelsList[widget.index].isInterested = "0";
                    debugPrint(state.toString());
                    Navigator.of(context).pop();
                    widget.videoController.play();
                  }
                },
                builder: (context, state) {
                  return TextButton(
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        elevation: 0,
                        // backgroundColor: Colors.black
                      ),
                      onPressed: state is ImpressionRemoveLoading
                          ? () {}
                          : () {
                              context.read<ImpressionCubit>().removeImpression(
                                  customerId: customerId,
                                  customerMobile: customerMobile,
                                  addId: adId,
                                  tableType: vehicleFrom,
                                  vechicleType: type,
                                  showroomId: showroomID);
                            },
                      child: state is ImpressionRemoveLoading
                          ? const CupertinoActivityIndicator()
                          : const Text(
                              "Submit",
                              textScaleFactor: 0.9,
                            ));
                },
              )
            ],
            title: const Text(
              "Delete interest ?",
              textScaleFactor: 0.7,
            ),
          );
        });
  }
}
