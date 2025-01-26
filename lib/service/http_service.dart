import 'dart:convert';

import 'package:http/http.dart' as http;

class HttpService {
  final String otpUrl = 'http://devapiv4.dealsdray.com/api/v2/user/otp';
  final String signUpUrl = 'http://devapiv4.dealsdray.com/api/v2/user/email/referral';
  final String userId = "62a833766ec5dafd6780fc85";
  final String homeScreenUrl = 'http://devapiv4.dealsdray.com/api/v2/user/home/withoutPrice';

  final Map<String, String> headers = {"Content-Type": "application/json"};

  Future<Map<String, dynamic>> sendOtpRequest(String mobileNumber) async {
    Map<String, dynamic> requestBody = {
      "mobileNumber": mobileNumber,
      "deviceId": "62b341aeb0ab5ebe28a758a3",
    };
    Map<String, dynamic> responseData;
    try {
      final response = await http.post(
        Uri.parse(otpUrl),
        body: jsonEncode(requestBody),
        headers: headers,
      );
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        responseData = jsonDecode(response.body);

        return responseData;
      } else {
        responseData = {"error": response.statusCode};
      }
    } catch (e) {
      return {"error": e};
    }
    return responseData = {"error": "error"};
  }

  Future<Map<String, dynamic>> singUpRequest(String email, String password, String referralCode) async {
    Map<String, dynamic> requestBody = {
      "email": email,
      "password": password,
      "referralCode": referralCode,
      "userId": userId,
    };
    Map<String, dynamic> responseData;
    try {
      final response = await http.post(
        Uri.parse(signUpUrl),
        headers: headers,
        body: jsonEncode(requestBody),
      );

      responseData = jsonDecode(response.body);

      return responseData;
    } catch (e) {
      return {"error": e};
    }
  }

  Future<Map<String, dynamic>> getHomeScreenDataRequest() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(homeScreenUrl));
      if (response.statusCode >= 200 && response.statusCode <= 300) {
        final Map<String, dynamic> responseData = jsonDecode(response.body);
        return responseData;
      }
    } catch (e) {
      return {'error': e};
    }
    return {'error': response.statusCode};
  }
}
