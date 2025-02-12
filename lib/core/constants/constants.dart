import 'package:flutter/material.dart';

import '../dto/api_request_dto.dart';

abstract class AppConstants {
  static ApiRequestDTO requestDTO = ApiRequestDTO(
    userName: "v",
    password: "v",
    deviceId: "7f2226495640ecb1",
    active: true,
    appType: "Mobile",
    firstName: "Vinay",
    lastName: "Emu",
    id: 3,
    orderCode: "VIE",
    orderCount: 98,
    orderPredictionCount: 19,
    role: "Driver",
    syncDate: "/Date(1720768210-600)/",
    pageIndex: 0,
    appVersionNo: "1.0",
    deviceDate: "/Date(1720768210-600)/",
  );
}

abstract class AppColors {
  static const Color primary = Color(0xfff84434);
}
