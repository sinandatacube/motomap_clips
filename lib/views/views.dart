import 'package:flutter/material.dart';
import 'package:motomap_clips/models/clips_model.dart';
import 'package:motomap_clips/models/reel_model.dart';
import 'package:motomap_clips/utils.dart';
import 'package:motomap_clips/utils/dynamic%20links/dynamic_link_handler.dart';
import 'package:motomap_clips/views/video_full_tile.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:html' as html;
import '../repository/api_repository.dart';
import '../utils/responsive/responsive.dart';

List reelsList = [];

class ReelHome extends StatefulWidget {
  final String customerId;
  final String customerName;
  final String customerMobile;
  final int initialIndex;
  const ReelHome(
      {super.key,
      required this.initialIndex,
      required this.customerId,
      required this.customerMobile,
      required this.customerName});

  @override
  State<ReelHome> createState() => _ReelHomeState();
}

class _ReelHomeState extends State<ReelHome> {
  late PageController pageController;
  // var user = HiveHelpers().getCredentials();
  bool isMute = false;
  addVideos(String startFrom) async {
    ClipsModel res = await ApiRepository()
        .fetchVideosContinously(startFrom, widget.customerId);
    for (var element in res.clips) {
      reelsList.add(ReelModel(
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
        dealerProfileUrl: companyLogoImagePath + element.companyImage,
        dealerName: element.showroomName,
        isInterested: element.isInterested, viewCount: element.viewCount,
        onShareClick: () async {
          var link =
              await DynamicLinkHandler().createDynamicLinkWithapiForVehicle(
            showroomId: element.showroomId,
            adId: element.adId,
            tableType: element.vehicleFrom,
            vehicleType: element.type,
          );
          // print("object");
          debugPrint(link);
          final result = await Share.share(
            link,
            subject: link,
          );
          // Share.shareWithResult(link);
          // Share.share(link);
        },

        onDealerClick: () {
          debugPrint(element.adId);
          debugPrint(element.type);
          debugPrint(element.vehicleFrom);
          debugPrint(element.showroomId);
          html.window.open(
              "https://motomap.in/Product?id=${element.adId}&vehicle_type=${element.type}&from=${element.vehicleFrom}&showroom=${element.showroomId}",
              'new tab');
          // navigatorKey.currentState!.push(
          //   MaterialPageRoute(
          //     builder: (context) => BlocProvider(
          //         create: (context) => ShowroomCubit(
          //             apiRepository: context.read<ApiRepository>(),
          //             internetRepository: context.read<InternetRepository>())
          //           ..loadShowroomDetails(id: element.showroomId),
          //         child: const ShowroomDetailScreen()),
          //   ),
          // );
        },
        vehicleName: "${element.brandName} ${element.model} ${element.varient}",
        postedDate: element.date,
        vehicleYear: element.regYear,
        adDescription: element.description,
      ));
    }
    setState(() {});
  }

  @override
  void initState() {
    pageController = PageController(initialPage: widget.initialIndex);
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    // reelsList.reduce((value, element) => null)
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        // margin: EdgeInsets.symmetric(
        //     horizontal: isTablet(context) ? size.width * 0.3 : 0),
        width: size.width,
        alignment: Alignment.center,
        child: AspectRatio(
          aspectRatio:
              MediaQuery.of(context).size.width > 768 ? 9 / 16 : 9 / 21,
          child: PageView.builder(
              reverse: true,
              controller: pageController,
              itemCount: reelsList.length,
              scrollDirection: Axis.vertical,
              onPageChanged: (i) async {
                ApiRepository()
                    .storeVideoCount(reelsList[i].clipId, widget.customerId);
                // addVideos((i + 1).toString());
                // if (i % 2 == 0) {
                //   addVideos(i.toString());
                // }
              },
              itemBuilder: (context, index) {
                return VideoFullTile(
                  customerMobile: widget.customerMobile,
                  customerId: widget.customerId,
                  customerName: widget.customerName,
                  index: index,
                  item: reelsList[index],
                  pageController: pageController,
                );
              }),
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:motomap_clips/models/clips_model.dart';
// import 'package:motomap_clips/models/reel_model.dart';
// import 'package:motomap_clips/utils.dart';
// import 'package:motomap_clips/utils/dynamic%20links/dynamic_link_handler.dart';
// import 'package:motomap_clips/views/video_full_tile.dart';
// import 'package:share_plus/share_plus.dart';
// import 'dart:html' as html;
// import '../repository/api_repository.dart';
// import '../utils/responsive/responsive.dart';

// List reelsList = [];

// class ReelHome extends StatefulWidget {
//   final String customerId;
//   final String customerName;
//   final String customerMobile;
//   final int initialIndex;

//   const ReelHome({
//     Key? key,
//     required this.initialIndex,
//     required this.customerId,
//     required this.customerMobile,
//     required this.customerName,
//   }) : super(key: key);

//   @override
//   State<ReelHome> createState() => _ReelHomeState();
// }

// class _ReelHomeState extends State<ReelHome> {
//   late PageController pageController;
//   List<ReelModel> reelsList = [];
//   bool isMute = false;

//   @override
//   void initState() {
//     pageController = PageController(initialPage: widget.initialIndex);
//     // addVideos(widget.initialIndex.toString());
//     super.initState();
//   }

//   Future<void> addVideos(String startFrom) async {
//     ClipsModel res = await ApiRepository().fetchVideosContinously(
//       startFrom,
//       widget.customerId,
//     );

//     List<ReelModel> newReelsList = [];

//     for (var element in res.clips) {
//       newReelsList.add(ReelModel(
//         adDescription: element.description,
//         adId: element.adId,
//         vehicleFrom: element.vehicleFrom,
//         vehicleType: element.type,
//         clipId: element.id,
//         dealerId: element.showroomId,
//         adVideoUrl: videoPath + element.fileName,
//         //  'https://player.vimeo.com/external/368320203.sd.mp4',
//         // 'https://assets.mixkit.co/videos/preview/mixkit-tree-with-yellow-flowers-1173-large.mp4',
//         interested: false,
//         onInterestClick: () {},
//         onChatClick: () {},
//         dealerProfileUrl: companyLogoImagePath + element.companyImage,
//         dealerName: element.showroomName,
//         isInterested: element.isInterested, viewCount: element.viewCount,
//         onShareClick: () async {
//           var link =
//               await DynamicLinkHandler().createDynamicLinkWithapiForVehicle(
//             showroomId: element.showroomId,
//             adId: element.adId,
//             tableType: element.vehicleFrom,
//             vehicleType: element.type,
//           );
//           // print("object");
//           debugPrint(link);
//           final result = await Share.share(
//             link,
//             subject: link,
//           );
//           // Share.shareWithResult(link);
//           // Share.share(link);
//         },

//         onDealerClick: () {
//           debugPrint(element.adId);
//           debugPrint(element.type);
//           debugPrint(element.vehicleFrom);
//           debugPrint(element.showroomId);
//           html.window.open(
//               "https://motomap.in/Product?id=${element.adId}&vehicle_type=${element.type}&from=${element.vehicleFrom}&showroom=${element.showroomId}",
//               'new tab');
//           // navigatorKey.currentState!.push(
//           //   MaterialPageRoute(
//           //     builder: (context) => BlocProvider(
//           //         create: (context) => ShowroomCubit(
//           //             apiRepository: context.read<ApiRepository>(),
//           //             internetRepository: context.read<InternetRepository>())
//           //           ..loadShowroomDetails(id: element.showroomId),
//           //         child: const ShowroomDetailScreen()),
//           //   ),
//           // );
//         },
//         vehicleName: "${element.brandName} ${element.model} ${element.varient}",
//         postedDate: element.date,
//         vehicleYear: element.regYear,
//       ));
//     }

//     setState(() {
//       reelsList.addAll(newReelsList);
//     });
//   }

//   @override
//   void dispose() {
//     pageController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Scaffold(
//       backgroundColor: Colors.black,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         foregroundColor: Colors.white,
//       ),
//       extendBodyBehindAppBar: true,
//       body: Container(
//         width: size.width,
//         alignment: Alignment.center,
//         child: reelsList.isEmpty
//             ? const CircularProgressIndicator() // Show loading indicator
//             : AspectRatio(
//                 aspectRatio:
//                     MediaQuery.of(context).size.width > 768 ? 9 / 16 : 9 / 21,
//                 child: PageView.builder(
//                   reverse: true,
//                   controller: pageController,
//                   itemCount: reelsList.length,
//                   scrollDirection: Axis.vertical,
//                   // onPageChanged: (i) async {
//                   //   ApiRepository().storeVideoCount(
//                   //       reelsList[i].clipId, widget.customerId);
//                   //   if (i % 2 == 0) {
//                   //     addVideos(i.toString());
//                   //   }
//                   // },
//                   itemBuilder: (context, index) {
//                     return VideoFullTile(
//                       customerMobile: widget.customerMobile,
//                       customerId: widget.customerId,
//                       customerName: widget.customerName,
//                       index: index,
//                       item: reelsList[index],
//                       pageController: pageController,
//                     );
//                   },
//                 ),
//               ),
//       ),
//     );
//   }
// }
