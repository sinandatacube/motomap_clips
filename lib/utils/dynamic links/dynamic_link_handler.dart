import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;

class DynamicLinkHandler {
  // /\/\/\/\/\/\/\\/\/\/\/\/\\// handle dynamic link

// /\/\/\/\/\/\/\\/\/\/\/\/\/\/\/ create dynamic link for vehicle

///////////////////////////////// create dynmaic link for vehicle
  createDynamicLinkWithapiForVehicle(
      {required String showroomId,
      required String adId,
      required String tableType,
      required String vehicleType}) async {
    String apiKey = 'AIzaSyCDGjTn8I8_XiCMqQEtixaSbeuBLbfgmso';
    Map params = {
      "dynamicLinkInfo": {
        "domainUriPrefix": "https://motomapadmi.page.link",
        // "link":
        //     "https://motomap.in/vehicle--$adId--$showroomId--$tableType--$vehicleType",
        "link":
            "https://motomap.in/Product?id=$adId&vehicle_type=$vehicleType&from=$tableType&showroom=$showroomId",
        "androidInfo": {
          "androidPackageName": "com.datacubeinfo.motomap",
        },
        "iosInfo": {
          "iosBundleId": "com.datacubeinfo.motomap",
          "iosAppStoreId": "6450534851",
        }
      }
    };

    var response = await http.post(
        Uri.parse(
            'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$apiKey'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(params));
    log(response.body.toString(), name: 'dynamic api');
    Map data = jsonDecode(response.body);
    return data['shortLink'];
  }

  //////////////////////////////// create dynmaic link for vehicle
  // createDynamicLinkWithapiForMotoClip({
  //   required String showroomId,
  //   required String adId,
  //   required String tableType,
  //   required String vehicleType,
  //   required String videoId,
  // }) async {
  //   String apiKey = 'AIzaSyCDGjTn8I8_XiCMqQEtixaSbeuBLbfgmso';
  //   Map params = {
  //     "dynamicLinkInfo": {
  //       "domainUriPrefix": "https://motomapadmi.page.link",
  //       // "link":
  //       //     "https://motomap.in/vehicle--$adId--$showroomId--$tableType--$vehicleType",
  //       "link": "https://motomap.in/Motomap/clips?id=$videoId",
  //       "androidInfo": {
  //         "androidPackageName": "com.datacubeinfo.motomap",
  //       },
  //       "iosInfo": {
  //         "iosBundleId": "com.datacubeinfo.motomap",
  //         "iosAppStoreId": "6450534851",
  //       }
  //     }
  //   };

  //   var response = await http.post(
  //       Uri.parse(
  //           'https://firebasedynamiclinks.googleapis.com/v1/shortLinks?key=$apiKey'),
  //       headers: {'Content-Type': 'application/json'},
  //       body: jsonEncode(params));
  //   log(response.body.toString(), name: 'dynamic api');
  //   Map data = jsonDecode(response.body);
  //   return data['shortLink'];
  // }
}
