// ignore_for_file: public_member_api_docs, sort_constructors_first
class ImpressionModel {
  final List<Impressions?> data;
  ImpressionModel({
    required this.data,
  });

  factory ImpressionModel.fromList(List<dynamic> list) => ImpressionModel(
      data: list.isEmpty
          ? []
          : List<Impressions>.from(list.map((e) => Impressions.fromJson(e))));
}

class Impressions {
  final String addId;
  final String showroomId;
  final String tableType;
  final String vechicleType;
  final String image;
  final String brand;
  final String model;
  final String variant;
  final String showroomName;
  final String km;
  final String price;
  Impressions({
    required this.addId,
    required this.showroomId,
    required this.tableType,
    required this.vechicleType,
    required this.image,
    required this.brand,
    required this.model,
    required this.variant,
    required this.showroomName,
    required this.km,
    required this.price,
  });

  factory Impressions.fromJson(Map<String, dynamic> json) => Impressions(
      addId: json['CarPurchase_Id'],
      showroomId: json['showroom'] ?? "",
      tableType: json['Table'] ?? "",
      vechicleType: json['type'] ?? "",
      // vechicleType: json['type'] ?? "",
      image: json['pImage'] ?? "",
      // brand: json['pBrand'] ?? "",
      brand: json['Brand_Name'] ?? "",
      // model: json['pModel'] ?? "",
      model: json['Car_Model'] ?? "",
      variant: json['Car_Varient'] ?? "",
      // variant: json['pVarient'] ?? "",
      showroomName: json['company_name'] ?? "",
      price: json['pSellingPrice'] ?? "",
      km: json['pKm'] ?? "");
}




// {"CarPurchase_Id":"62",
// "pDate":"2023-07-05",
// "pImage":"mercedes-4matic-guide-carwow-lead-mercedes-glc-coupe.png",
// "pKm":"1000",
// "showroom":"54",
// "pSellingPrice":"1450000",
// "Brand_Name":"Mercedes Benz",
// "Car_Model":"450 4MATIC",
// "Car_Varient":"400d",
// "type":"car","intrst_id":"18","insrt_date":"2023-07-06","post_public":"1",
// "Table":"list",
// "customer_name":"test","user_contact_number":"9633097509","company_name":"ACE Motors"}