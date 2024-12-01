import 'dart:convert';

import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/vendor.dart';
import 'package:grocery_web/services/manage_http_response.dart';

import 'package:http/http.dart' as http;

class VendorAuthController {
  Future<void> signUpVendor(
      {required String fullName,
      required String email,
      required String password,
      required context}) async {
    try {
      Vendor vendor = Vendor(
        id: '', // <-- Phần này có vấn đề
        fullName: fullName,
        email: email,
        state: '',
        city: '',
        locality: '',
        role: '',
        password: password,
      );

      http.Response response = await http.post(
          Uri.parse("$uri/api/vendor/signup"),
          body: vendor
              .toJson(), //Covert the Vendor user object to json for the request body
          headers: <String, String>{
            //Set the Headers for the request
            "Content-Type": 'application/json; charset=UTF-8',
          });

      manageHtppResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Vendor Account Created');
        },
      ); // Có vẻ như còn thiếu lệnh gọi hàm ở đây
    } catch (e) {
      showSnackBar(context, '$e');
    }
  }

  Future<void> signInVendor(
      {required String email,
      required String password,
      required context}) async {
    try {
      http.Response response = await http.post(
        Uri.parse('$uri/api/vendor/signin'),
        body: jsonEncode({'email': email, 'password': password}),
        headers: <String, String>{
          "Content-Type": 'application/json; charset=UTF-8',
        },
      );

      manageHtppResponse(
          response: response,
          context: context,
          onSuccess: () {
            showSnackBar(context, 'Logged in successfully');
          });
    } catch (e) {
      // Xử lý lỗi ở đây
      showSnackBar(context, '$e');
    }
  }
}
