import 'dart:convert';

import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/vendor.dart';
import 'package:http/http.dart' as http;

class VendorController {
  Future<List<Vendor>> loadVendors() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/vendors'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Vendor> vendors =
            data.map((vendor) => Vendor.fromMap(vendor)).toList();
        print(vendors);
        return vendors;
      } else {
        throw Exception("Failed to load vendors");
      }
    } catch (e) {
      throw Exception("Error to loading vendors $e");
    }
  }
}
