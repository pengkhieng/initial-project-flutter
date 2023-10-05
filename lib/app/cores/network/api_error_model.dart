import 'package:annotation/app/repos/core.dart';

class ApiErrorModel {
  ApiErrorModel({
    required this.status,
    required this.message,
    required this.code,
  });
  ApiErrorModel.fromJson(Map<String, dynamic> json) {
    status = int.parse(json['status'].toString().checkNullString('0'));
    message = json['message'].toString().checkNullString();
    code = json['code'].toString().checkNullString();
  }
  late final int status;
  late final String message;
  late final String code;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    data['code'] = code;
    return data;
  }
}
