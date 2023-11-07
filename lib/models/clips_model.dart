import 'dart:convert';

ClipsModel clipsModelFromJson(String str) =>
    ClipsModel.fromJson(json.decode(str));

// String clipsModelToJson(ClipsModel data) => json.encode(data.toJson());

class ClipsModel {
  List<Clip> clips;

  ClipsModel({
    required this.clips,
  });

  factory ClipsModel.fromJson(Map<String, dynamic> json) => ClipsModel(
        clips: List<Clip>.from(json["clips"].map((x) => Clip.fromJson(x))),
      );

  // Map<String, dynamic> toJson() => {
  //       "clips": List<dynamic>.from(clips.map((x) => x.toJson())),
  //     };
}

class Clip {
  String id;
  String createdAt;
  String fileName;
  String listId;
  String showroomId;
  String showroomName;
  String brandName;
  String model;
  String varient;
  String type;
  String date;
  String regYear;
  String description;
  String vehicleFrom;
  String companyImage;
  String adId;
  String viewCount;
  String isInterested;

  Clip({
    required this.id,
    required this.createdAt,
    required this.fileName,
    required this.listId,
    required this.showroomId,
    required this.showroomName,
    required this.brandName,
    required this.date,
    required this.adId,
    required this.description,
    required this.model,
    required this.regYear,
    required this.type,
    required this.varient,
    required this.vehicleFrom,
    required this.companyImage,
    required this.isInterested,
    required this.viewCount,
  });

  factory Clip.fromJson(Map<String, dynamic> json) => Clip(
        id: json["clip_id"],
        createdAt: json["created_at"] ?? "",
        listId: json["list_id"],
        showroomId: json["showroom"] ?? "",
        fileName: json["clip_name"] ?? "",
        showroomName: json["company_name"] ?? "",
        brandName: json["Brand_Name"] ?? "",
        date: json["lDate"] ?? "",
        description: json["lAdditionalInfo"] ?? "",
        model: json["Car_Model"] ?? "",
        regYear: json["lRegYear"] ?? "",
        type: json["type"] ?? "",
        varient: json["Car_Varient"] ?? "",
        vehicleFrom: json["vehicle_from"] ?? "",
        companyImage: json["company_logo"] ?? "",
        adId: json["list_id"] ?? "",
        viewCount: json["clip_view_count"] ?? "",
        isInterested: json["user_interested"] ?? "",
      );

  // Map<String, dynamic> toJson() => {
  //       "id": id,
  //       "showroom": showroom,
  //       "ad_id": adId,
  //       "file_name": fileName,
  //       "description": description,
  //       "file_path": filePath,
  //       "upload_date": uploadDate.toIso8601String(),
  //     };
}
