import 'dart:convert';

import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/buyer.dart';
import 'package:http/http.dart' as http;

class BuyerCotnroller {
  Future<List<Buyer>> loadBuyers() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/users'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<Buyer> buyers = data.map((buyer) => Buyer.fromMap(buyer)).toList();
        return buyers;
      } else {
        throw Exception("Failed to load buyers");
      }
    } catch (e) {
      throw Exception("Error to loading buyerss $e");
    }
  }
}
