import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:motomap_clips/firebase_options.dart';
import 'dart:html' as html;

import 'package:motomap_clips/views/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// firebase init
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Moto clips",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ReelInit(),
    );
  }
}

// class ReelInit extends StatelessWidget {
//   const ReelInit({super.key});

//   getCurrentURL() async {
//     String url = html.window.location.href;
//     // String url = getCurrentURL();
//     Uri uri = Uri.parse(
//       // url
//       "https://motomap-c960c.web.app/?userId=2&userName=prathewsh&userMobile=8893990552",
//     );

//     String userMobile = uri.queryParameters['userMobile'] ?? '';
//     String userId = uri.queryParameters['userId'] ?? '';
//     String userName = uri.queryParameters['userName'] ?? '';
//     return Future.value(
//         {"userMobile": userMobile, "userId": userId, "userName": userName});
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.sizeOf(context);
//     return Scaffold(
//         body: SizedBox(
//       height: size.height,
//       width: size.width,
//       child: FutureBuilder(
//           future: getCurrentURL(),
//           builder: (context, AsyncSnapshot snapshot) {
//             Map data = snapshot.data;
//             if (snapshot.hasData) {
//               return ReelFetchInitialData(
//                   userId: data["userId"],
//                   userMobile: data["userMobile"],
//                   userName: data["userMobile"]);
//             } else if (snapshot.hasError) {
//               return const Text("Something went wrong");
//             } else {
//               return const CircularProgressIndicator();
//             }
//           }),
//     ));
//   }
// }

// class ReelFetchInitialData extends StatelessWidget {
//   final String userId;
//   final String userName;
//   final String userMobile;
//   const ReelFetchInitialData(
//       {super.key,
//       required this.userId,
//       required this.userMobile,
//       required this.userName});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: FutureBuilder(
//           future: ApiRepository().fetchVideosContinously("0", userId),
//           builder: (context, AsyncSnapshot snapshot) {
//             if (snapshot.hasData) {
//               return ReelHome(
//                   initialIndex: 0,
//                   customerId: userId,
//                   customerMobile: userMobile,
//                   customerName: userMobile);
//             } else if (snapshot.hasError) {
//               return Center(
//                 child: Text("Something went wrong"),
//               );
//             } else {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             }
//           }),
//     );
//   }
// }
