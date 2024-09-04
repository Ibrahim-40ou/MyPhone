class MyOrder {
  late String? orderId;
  final String? userId;
  final String? recipientFullName;
  final String? phoneNumber;
  final String? governorate;
  final String? closestKnownPoint;
  final String? status;
  final String? date;
  final String? totalPrice;

  MyOrder({
    this.orderId,
    required this.userId,
    required this.recipientFullName,
    required this.phoneNumber,
    required this.governorate,
    required this.closestKnownPoint,
    required this.status,
    required this.date,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'orderId': orderId,
      'userId': userId,
      'recipientFullName': recipientFullName,
      'phoneNumber': phoneNumber,
      'governorate': governorate,
      'closestKnownPoint': closestKnownPoint,
      'status': status,
      'date': date,
      'totalPrice' : totalPrice,
    };
  }

  static MyOrder fromJson(Map<String, dynamic> json) {
    return MyOrder(
      orderId: json['orderId'],
      userId: json['userId'],
      recipientFullName: json['recipientFullName'],
      phoneNumber: json['phoneNumber'],
      governorate: json['governorate'],
      closestKnownPoint: json['closestKnownPoint'],
      status: json['status'],
      date: json['date'],
      totalPrice: json['totalPrice'],
    );
  }
}
