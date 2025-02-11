class CustomerRequestDTO {
  final String userName;
  final String password;
  final String deviceId;
  final bool active;
  final String appType;
  final String syncDate;
  final int pageIndex;

  CustomerRequestDTO({
    required this.userName,
    required this.password,
    required this.deviceId,
    required this.active,
    required this.appType,
    required this.syncDate,
    required this.pageIndex,
  });

  Map<String, dynamic> toJson() => {
        "user": {
          "UserName": userName,
          "Password": password,
          "DeviceId": deviceId,
          "Active": active,
          "AppType": appType,
        },
        "syncDate": syncDate,
        "pageIndex": pageIndex,
      };
}
