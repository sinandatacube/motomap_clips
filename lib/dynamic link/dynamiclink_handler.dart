// import 'dart:convert';
// import 'dart:developer';
// import 'package:http/http.dart' as http;
// import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
// import 'package:flutter/material.dart';
// import 'package:motomap/presentation/productDetail/product_detail_screen.dart';
// import 'package:motomap/presentation/showroomDetail/showroom_detail_screen.dart';

// import '../logic/bloc_exports.dart';
// import '../repository/api_repository.dart';
// import '../repository/internet_repository.dart';
// import '../utils/utils.dart';

// class DynamicLinkHandler {
//   // /\/\/\/\/\/\/\\/\/\/\/\/\\// handle dynamic link
//   handleDynamicLink() async {
//     // Check if you received the link via `getInitialLink` first
//     final PendingDynamicLinkData? initialLink =
//         await FirebaseDynamicLinks.instance.getInitialLink();

//     if (initialLink != null) {
//       final Uri deepLink = initialLink.link;
//       // Example of using the dynamic link to push the user to a different screen
//       log(deepLink.toString(), name: "0000000000");
//       String productId = deepLink.toString().split("--")[1];
//       log(deepLink.toString().split("--")[1], name: "00000000002");

//       if (deepLink.toString().contains('Showroom')) {
//         String productId = deepLink.toString().split("=")[1];
//         navigatorKey.currentState!.push(
//           MaterialPageRoute(
//             builder: (context) => BlocProvider(
//                 create: (context) => ShowroomCubit(
//                     apiRepository: context.read<ApiRepository>(),
//                     internetRepository: context.read<InternetRepository>())
//                   ..loadShowroomDetails(id: productId),
//                 child: const ShowroomDetailScreen()),
//           ),
//         );
//       }

//       /////// goto vehicle details
//       if (deepLink.toString().contains('Product')) {
//         //  "link":"https://motomap.in/Product?id=$adId&vehicle_type=$vehicleType&from=$tableType&showroom=$showroomId",
//         // String productId = deepLink.toString().split("=")[1];
//         // String showroomId = deepLink.toString().split("=")[2];
//         // String tableType = deepLink.toString().split("=")[3];
//         // String vehicleType = deepLink.toString().split("=")[4];
//         String url = deepLink.toString();
//         Uri uri = Uri.parse(url);

//         String productId = uri.queryParameters['id'] ?? '';
//         String vehicleType = uri.queryParameters['vehicle_type'] ?? '';
//         String tableType = uri.queryParameters['from'] ?? '';
//         String showroomId = uri.queryParameters['showroom'] ?? '';
//         log(productId);
//         log(showroomId);
//         log(tableType);
//         log(vehicleType);
//         navigatorKey.currentState!.push(
//           MaterialPageRoute(
//               builder: (context) => MultiBlocProvider(
//                     providers: [
//                       BlocProvider(
//                         create: (context) => DetailsCubit(
//                             apiRepository: context.read<ApiRepository>(),
//                             internetRepository:
//                                 context.read<InternetRepository>())
//                           ..loadDetails(
//                               showroomId: showroomId,
//                               id: productId,
//                               tableType: tableType,
//                               type: vehicleType),
//                       ),
//                       BlocProvider(
//                         create: (context) => ImpressionCubit(
//                             apiRepository: context.read<ApiRepository>()),
//                       )
//                     ],
//                     child: ProductDetailScreen(
//                         showShowroom: true, type: vehicleType),
//                   )),
//         );
//       }
//     }

//     FirebaseDynamicLinks.instance.onLink.listen(
//       (pendingDynamicLinkData) {
//         // Set up the `onLink` event listener next as it may be received here
//         if (pendingDynamicLinkData != null) {
//           final Uri deepLink = pendingDynamicLinkData.link;
//           log(deepLink.toString(), name: "d1111111111");
//           // String productId = deepLink.toString().split("--")[1];
//           log("-----------------------------------------------");
//           //goto showroom details
//           if (deepLink.toString().contains('Showroom')) {
//             String productId = deepLink.toString().split("=")[1];
//             navigatorKey.currentState!.push(
//               MaterialPageRoute(
//                 builder: (context) => BlocProvider(
//                     create: (context) => ShowroomCubit(
//                         apiRepository: context.read<ApiRepository>(),
//                         internetRepository: context.read<InternetRepository>())
//                       ..loadShowroomDetails(id: productId),
//                     child: const ShowroomDetailScreen()),
//               ),
//             );
//           }

//           /////// goto vehicle details
//           if (deepLink.toString().contains('Product')) {
//             String url = deepLink.toString();
//             Uri uri = Uri.parse(url);

//             String productId = uri.queryParameters['id'] ?? '';
//             String vehicleType = uri.queryParameters['vehicle_type'] ?? '';
//             String tableType = uri.queryParameters['from'] ?? '';
//             String showroomId = uri.queryParameters['showroom'] ?? '';
//             log(productId);
//             log(showroomId);
//             log(tableType);
//             log(vehicleType);
//             navigatorKey.currentState!.push(
//               MaterialPageRoute(
//                   builder: (context) => MultiBlocProvider(
//                         providers: [
//                           BlocProvider(
//                             create: (context) => DetailsCubit(
//                                 apiRepository: context.read<ApiRepository>(),
//                                 internetRepository:
//                                     context.read<InternetRepository>())
//                               ..loadDetails(
//                                   showroomId: showroomId,
//                                   id: productId,
//                                   tableType: tableType,
//                                   type: vehicleType),
//                           ),
//                           BlocProvider(
//                             create: (context) => ImpressionCubit(
//                                 apiRepository: context.read<ApiRepository>()),
//                           )
//                         ],
//                         child: ProductDetailScreen(
//                             showShowroom: true, type: vehicleType),
//                       )),
//             );
//           }
//         }
//       },
//     );
//     // FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
//     //   log(dynamicLinkData.toString(), name: "d222222222");
//     //   String productId = dynamicLinkData.link.toString().split("--")[1];
//     //   log("-----------------------------------------------");
//     //   navigatorKey.currentState?.push(MaterialPageRoute(
//     //       builder: (_) => VehicleDetails(purchaseId: productId)));
//     //   return;
//     // }).onError((error) {
//     //   // Handle errors
//     // });
//     // }
//   }

// // /\/\/\/\/\/\/\\/\/\/\/\/\/\/\/ create dynamic link for vehicle

// ///////////////////////////////// create dynmaic link for vehicle
//   createDynamicLinkWithapiForVehicle(
//       {required String showroomId,
//       required String adId,
//       required String tableType,
//       required String vehicleType}) async {
//     String apiKey = 'AIzaSyCDGjTn8I8_XiCMqQEtixaSbeuBLbfgmso';
//     Map params = {
//       "dynamicLinkInfo": {
//         "domainUriPrefix": "https://motomapadmi.page.link",
//         // "link":
//         //     "https://motomap.in/vehicle--$adId--$showroomId--$tableType--$vehicleType",
//         "link":
//             "https://motomap.in/Product?id=$adId&vehicle_type=$vehicleType&from=$tableType&showroom=$showroomId",
//         "androidInfo": {
//           "androidPackageName": "com.datacubeinfo.motomap",
//         },
//         "iosInfo": {
//           "iosBundleId": "com.datacubeinfo.motomap",
//           "iosAppStoreId": "6450534851",
//         }
//       }
//     };

//     var response = await http.post(
//         Uri.parse(
//             'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$apiKey'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(params));
//     log(response.body.toString(), name: 'dynamic api');
//     Map data = jsonDecode(response.body);
//     return data['shortLink'];
//   }

//   //////////////////////////////// create dynmaic link for vehicle
//   createDynamicLinkWithapiForMotoClip({
//     required String showroomId,
//     required String adId,
//     required String tableType,
//     required String vehicleType,
//     required String videoId,
//   }) async {
//     String apiKey = 'AIzaSyCDGjTn8I8_XiCMqQEtixaSbeuBLbfgmso';
//     Map params = {
//       "dynamicLinkInfo": {
//         "domainUriPrefix": "https://motomapadmi.page.link",
//         // "link":
//         //     "https://motomap.in/vehicle--$adId--$showroomId--$tableType--$vehicleType",
//         "link": "https://motomap.in/Motomap/clips?id=$videoId",
//         "androidInfo": {
//           "androidPackageName": "com.datacubeinfo.motomap",
//         },
//         "iosInfo": {
//           "iosBundleId": "com.datacubeinfo.motomap",
//           "iosAppStoreId": "6450534851",
//         }
//       }
//     };

//     var response = await http.post(
//         Uri.parse(
//             'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$apiKey'),
//         headers: {'Content-Type': 'application/json'},
//         body: jsonEncode(params));
//     log(response.body.toString(), name: 'dynamic api');
//     Map data = jsonDecode(response.body);
//     return data['shortLink'];
//   }
// }
