class ReelModel {
  final String clipId;
  final String dealerId;

  final String adVideoUrl;

  final bool interested;
  final Function onInterestClick;

  final Function onChatClick;

  final String dealerProfileUrl;
  final String dealerName;
  final Function onDealerClick;
  final Function onShareClick;

  final String vehicleName;

  final String postedDate;

  final String vehicleYear;

  final String adDescription;
  final String viewCount;
  String isInterested;
  final String adId;
  final String vehicleType;
  final String vehicleFrom;

  ReelModel({
    required this.clipId,
    required this.dealerId,
    required this.onShareClick,
    required this.adVideoUrl,
    required this.interested,
    required this.onInterestClick,
    required this.onChatClick,
    required this.dealerProfileUrl,
    required this.dealerName,
    required this.onDealerClick,
    required this.vehicleName,
    required this.postedDate,
    required this.vehicleYear,
    required this.adDescription,
    required this.isInterested,
    required this.viewCount,
    required this.adId,
    required this.vehicleFrom,
    required this.vehicleType,
  });
}
