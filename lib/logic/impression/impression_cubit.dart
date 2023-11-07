import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:motomap_clips/repository/api_repository.dart';

import '../../models/impression_model.dart';

part 'impression_state.dart';

class ImpressionCubit extends Cubit<ImpressionState> {
  final ApiRepository apiRepository;
  ImpressionCubit({required this.apiRepository}) : super(ImpressionInitial());

  setImpression({
    required addId,
    required showroomId,
    required tableType,
    required vechicleType,
    required isTestDrive,
    required testDriveDate,
    required isExchange,
    required customerId,
    required customerName,
    required customerMobile,
  }) async {
    try {
      emit(ImpressionLoading());
      // var user = HiveHelpers().getCredentials();
      if (customerId == null) {
        emit(ImpressionNoUser());
      } else {
        var res = await apiRepository.setImpression(
            tableType: tableType,
            vechicleType: vechicleType,
            userId: customerId,
            userMobile: customerMobile,
            addId: addId,
            isExchange: isExchange,
            isTestdrive: isTestDrive,
            testdriveDate: testDriveDate,
            showroomId: showroomId);
        debugPrint(res.toString() + " bnm");

        if (res['status'] == "ok") {
          emit(ImpressionSet());
        } else {
          emit(ImpressionError(error: res['message']));
        }
      }
    } catch (e) {
      debugPrint(e.toString() + " client error");
      emit(ImpressionError(error: e.toString()));
    }
  }

  removeImpression(
      {required addId,
      required showroomId,
      required tableType,
      required customerId,
      required customerMobile,
      required vechicleType}) async {
    try {
      emit(ImpressionRemoveLoading());
      // var user = HiveHelpers().getCredentials();
      var res = await apiRepository.setImpression(
          tableType: tableType,
          vechicleType: vechicleType,
          userId: customerId,
          userMobile: customerMobile,
          addId: addId,
          isExchange: "",
          testdriveDate: "",
          isTestdrive: "",
          showroomId: showroomId);
      if (res['status'] == "ok") {
        emit(ImpressionRemoved());
      } else {
        emit(ImpressionError(error: res['message']));
      }
    } catch (e) {
      emit(ImpressionError(error: e.toString()));
    }
  }

//////////////// get user impressionss

  getUsersImpressions(String userId) async {
    try {
      emit(ImpressionLoading());
      // var user = HiveHelpers().getCredentials();
      if (userId == null) {
        emit(const ImpressionError(
            error: "Please complete your profile to access this feature !!"));
      } else {
        var data = await apiRepository.getIntersetedAdds(id: userId);
        if (data['status'] == 'ok') {
          var result = data['data'] as ImpressionModel;

          emit(ImpressionsLoaded(data: result.data));
        } else {
          log(data['message'].toString(), name: 'error on impression lodingg');

          emit(ImpressionError(error: data['message']));
        }
      }
    } catch (e) {
      log(e.toString(), name: 'error on impression loding');
      emit(ImpressionError(error: e.toString()));
    }
  }
  /////////////////// interested adds /

  // getIntersetedAdds({required id}) async {
  //   try {
  //     Map params = {"user_id": id};

  //     var res =
  //         await http.post(Uri.parse(Config.getInterestedUrl), body: params);
  //     debugPrint(res.body.toString());
  //     if (res.statusCode == 200) {
  //       var body = jsonDecode(res.body);
  //       debugPrint(body.toString() + " res body");

  //       return {"status": "ok", "data": ImpressionModel.fromList(body)};
  //     } else {
  //       return {"status": "failed", "message": "!200"};
  //     }
  //   } catch (e) {
  //     debugPrint(e.toString() + "api error in impression loading");
  //     return {"status": "failed", "message": "some server error occured"};
  //   }
  // }
}
