import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:motomap_clips/models/clips_model.dart';
import 'package:motomap_clips/utils.dart';

import '../models/impression_model.dart';

class ApiRepository {
  //////////////////////////////////////////////////

  fetchVideosContinously(String startFrom, String userId) async {
    try {
      Map params = {'uid': userId, 'startFrom': startFrom};
      debugPrint(params.toString() + " asfdsaf");
      var res = await http.post(Uri.parse(continousVideosUrl), body: params);
      debugPrint(res.body.toString() + "motification res body");
      debugPrint(res.statusCode.toString() + "motification res body");
      debugPrint("res.body.toString()" + "motification res body");

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        debugPrint(body.toString() + "motification res body");

        ClipsModel clips = ClipsModel.fromJson(body);
        return clips;
      }
    } catch (e) {
      debugPrint(e.toString() + "motification api error");
    }
  } //////////////////////////////////////////////////

  fetchinitialVideo(String startFrom, String userId, String count) async {
    try {
      Map params = {'uid': userId, 'startFrom': startFrom, 'amt': count};
      debugPrint(params.toString() + " a");
      var res = await http.post(Uri.parse(initialVideosUrl), body: params);
      debugPrint(res.body.toString() + "initial1");
      debugPrint(res.statusCode.toString() + "initial12");

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        // debugPrint(body.toString() + "initial3");

        ClipsModel clips = ClipsModel.fromJson(body);
        return clips;
      }
    } catch (e) {
      debugPrint(e.toString() + "motification api error");
    }
  }

  //////////////////////////////////////////////////

  storeVideoCount(String clipId, String userId) async {
    try {
      Map params = {'clip_id': clipId, 'user_id': userId};
      var res = await http.post(Uri.parse(storeViewUrl), body: params);
      debugPrint(params.toString() + " paramsss");
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        debugPrint(res.body.toString());
        if (body['response'] == 'success') {
          return {'status': 'success'};
        }
      }
    } catch (e) {
      debugPrint(e.toString() + "motification api error");
    }
  }

////////////////// impression /////////////////////////////

  setImpression(
      {required userId,
      required userMobile,
      required addId,
      required vechicleType,
      required tableType,
      required isExchange,
      required isTestdrive,
      required testdriveDate,
      required showroomId}) async {
    try {
      Map params = {
        "user_id": userId,
        "mobileNumber": userMobile,
        "adId": addId,
        "shwrm_id": showroomId,
        "vehicle_type": vechicleType,
        "table": tableType,
        "isTestDrive": isTestdrive,
        "TestDate": testdriveDate,
        "isExchange": isExchange,
      };
      debugPrint(params.toString() + " imression");
      var res = await http.post(Uri.parse(impressionUrl), body: params);
      debugPrint(res.body.toString() + " body");

      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        debugPrint(body.toString() + " body");

        if (body['status'] == "success") {
          return {"status": "ok", "data": "ok"};
        } else {
          return {"status": "failed", "message": "some error occured"};
        }
      } else {
        return {"status": "failed", "message": "!200"};
      }
    } catch (e) {
      return {"status": "failed", "message": "some server error occured"};
    }
  }

//////////////////// interested adds /

  getIntersetedAdds({required id}) async {
    try {
      Map params = {"user_id": id};

      var res = await http.post(Uri.parse(getInterestedUrl), body: params);
      debugPrint(res.body.toString());
      if (res.statusCode == 200) {
        var body = jsonDecode(res.body);
        debugPrint(body.toString() + " res body");

        return {"status": "ok", "data": ImpressionModel.fromList(body)};
      } else {
        return {"status": "failed", "message": "!200"};
      }
    } catch (e) {
      debugPrint(e.toString() + "api error in impression loading");
      return {"status": "failed", "message": "some server error occured"};
    }
  }
}
