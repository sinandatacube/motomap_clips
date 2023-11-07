import 'package:flutter/material.dart';
import 'package:motomap_clips/models/clips_model.dart';
import 'dart:html' as html;

import 'package:motomap_clips/repository/api_repository.dart';
import 'package:motomap_clips/views/views.dart';
import 'package:share_plus/share_plus.dart';

import '../models/reel_model.dart';
import '../utils.dart';
import '../utils/dynamic links/dynamic_link_handler.dart';

class ReelInit extends StatelessWidget {
  const ReelInit({super.key});

  getCurrentURL() async {
    String url = html.window.location.href;
    // String url = getCurrentURL();
    Uri uri = Uri.parse(
      // url
      "https://motomap-c960c.web.app/?userId=2&userName=prathewsh&userMobile=8893990552",
    );

    String userMobile = uri.queryParameters['userMobile'] ?? '';
    String userId = uri.queryParameters['userId'] ?? '';
    String userName = uri.queryParameters['userName'] ?? '';

    return Future.value(
        {"userMobile": userMobile, "userId": userId, "userName": userName});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
        body: SizedBox(
      height: size.height,
      width: size.width,
      child: FutureBuilder(
          future: getCurrentURL(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              Map data = snapshot.data;
              debugPrint(snapshot.data.toString() + " get url");
              return ReelFetchInitialData(
                  userId: data["userId"],
                  userMobile: data["userMobile"],
                  userName: data["userName"]);
            } else if (snapshot.hasError) {
              return const Text("Something went wrong");
            } else {
              return const CircularProgressIndicator();
            }
          }),
    ));
  }
}

class ReelFetchInitialData extends StatelessWidget {
  final String userId;
  final String userName;
  final String userMobile;
  ReelFetchInitialData(
      {super.key,
      required this.userId,
      required this.userMobile,
      required this.userName});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: ApiRepository().fetchinitialVideo("0", userId, "2"),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              debugPrint(snapshot.data.toString() + " clips");

              ClipsModel data = snapshot.data;
              reelsList.clear();
              for (var element in data.clips) {
                reelsList.add(
                  ReelModel(
                    adId: element.adId,
                    vehicleFrom: element.vehicleFrom,
                    vehicleType: element.type,
                    clipId: element.id,
                    dealerId: element.showroomId,
                    adVideoUrl: videoPath + element.fileName,
                    //  'https://player.vimeo.com/external/368320203.sd.mp4',
                    // 'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
                    interested: false,
                    onInterestClick: () {},
                    onChatClick: () {},
                    isInterested: element.isInterested,
                    viewCount: element.viewCount,
                    onShareClick: () async {
                      var link = await DynamicLinkHandler()
                          .createDynamicLinkWithapiForVehicle(
                        showroomId: element.showroomId,
                        adId: element.adId,
                        tableType: element.vehicleFrom,
                        vehicleType: element.type,
                      );
                      debugPrint(link);
                      final result = await Share.share(
                        link,
                        subject: link,
                      );

                      // Share.share(link);
                      // Share.shareWithResult(link);
                    },

                    dealerProfileUrl:
                        companyLogoImagePath + element.companyImage,
                    dealerName: element.showroomName,
                    onDealerClick: () {
                      html.window.open(
                          "https://motomap.in/Product?id=${element.adId}&vehicle_type=${element.type}&from=${element.vehicleFrom}&showroom=${element.showroomId}",
                          'new tab');
                    },
                    vehicleName:
                        "${element.brandName} ${element.model} ${element.varient}",
                    postedDate: element.date,
                    vehicleYear: element.regYear,
                    adDescription: element.description,
                  ),
                );
              }
              return ReelHome(
                  initialIndex: 0,
                  customerId: userId,
                  customerMobile: userMobile,
                  customerName: userMobile);
            } else if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          }),
    );
  }
}
