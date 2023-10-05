// ignore_for_file: camel_case_types, constant_identifier_names

enum API_STATUS { initial, loading, success, error, loading_more }

enum INPUT_PHONE_TYPE {
  NEW_PHONE,
  FORGOT_PASSWORD,
  REGISTER,
}

enum NotificationType { zone, announcement, checkin_success }

enum OTP_Request_Type {
  FORGOT_PASSWORD,
  REGISTER,
  CONFIRM_NEW_PHONE,
  CONFIRM_OLD_PHONE,
}

enum TOAST_STATUS { SUCCESS, ERROR, WARNING, INFO }
