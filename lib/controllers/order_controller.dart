import 'dart:convert';

import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/order.dart';
import 'package:http/http.dart' as http;

class OrderController {
  Future<List<Order>> loadOrders() async {
    try {
      //send an http get request to fetch the list of orders from the server
      http.Response response = await http.get(
        Uri.parse('$uri/api/orders'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      //check if the http response status code is 200, meaning the request was successful
      if (response.statusCode == 200) {
        //decode the json response body into list of dynamic object
        List<dynamic> data = jsonDecode(response.body);
        List<Order> orders =
            data.map((order) => Order.fromJson(order)).toList();

        return orders;
      } else {
        throw Exception("failed to load order");
      }
    } catch (e) {
      throw Exception("error to loading orders $e");
    }
  }
}
