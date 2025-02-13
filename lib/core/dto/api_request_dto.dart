class ApiRequestDTO {
  final String userName;
  final String password;
  final String deviceId;
  final bool active;
  final String appType;
  final String firstName;
  final String lastName;
  final int id;
  final String orderCode;
  final int orderCount;
  final int orderPredictionCount;
  final String role;
  final bool? isResetSync;
  final String syncDate;
  final int pageIndex;
  final String appVersionNo;
  final String deviceDate;

  ApiRequestDTO({
    required this.userName,
    required this.password,
    required this.deviceId,
    required this.active,
    required this.appType,
    required this.firstName,
    required this.lastName,
    required this.id,
    required this.orderCode,
    required this.orderCount,
    required this.orderPredictionCount,
    required this.role,
    this.isResetSync,
    required this.syncDate,
    required this.pageIndex,
    required this.appVersionNo,
    required this.deviceDate,
  });

  Map<String, dynamic> toJson() => {
        "user": {
          "UserName": userName,
          "Password": password,
          "DeviceId": deviceId,
          "Active": active,
          "AppType": appType,
          "FirstName": firstName,
          "LastName": lastName,
          "Id": id,
          "OrderCode": orderCode,
          "OrderCount": orderCount,
          "OrderPredictionCount": orderPredictionCount,
          "Role": role,
          if (isResetSync != null) "IsResetSync": isResetSync,
        },
        "syncDate": formatDate(syncDate),
        "pageIndex": pageIndex,
        "appVersionNo": appVersionNo,
        "deviceDate": formatDate(deviceDate),
      };

  String formatDate(String date) =>
      date.startsWith("/Date(") ? date : '/Date($date-600)/';

  /// Factory method to create an instance from JSON
  factory ApiRequestDTO.fromJson(Map<String, dynamic> json) {
    final user = json["user"];
    return ApiRequestDTO(
      userName: user["UserName"] ?? "",
      password: user["Password"] ?? "",
      deviceId: user["DeviceId"] ?? "",
      active: user["Active"] ?? false,
      appType: user["AppType"] ?? "Unknown",
      firstName: user["FirstName"] ?? "",
      lastName: user["LastName"] ?? "",
      id: user["Id"] ?? 0,
      orderCode: user["OrderCode"] ?? "",
      orderCount: user["OrderCount"] ?? 0,
      orderPredictionCount: user["OrderPredictionCount"] ?? 0,
      role: user["Role"] ?? "",
      isResetSync: user.containsKey("IsResetSync") ? user["IsResetSync"] : null,
      syncDate: json["syncDate"] ?? "",
      pageIndex: json["pageIndex"] ?? 0,
      appVersionNo: json["appVersionNo"] ?? "",
      deviceDate: json["deviceDate"] ?? "",
    );
  }
}
