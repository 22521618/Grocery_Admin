import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/categpry.dart';
import 'package:grocery_web/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dwrchdx6d", 'rietpo2b');

      //upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'categoryImages'),
      );
      String image = imageResponse.secureUrl;

      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner,
            identifier: 'pickedBanner', folder: 'categoryImages'),
      );
      String banner = bannerResponse.secureUrl;
      print(image);
      print(banner);

      Category category = Category(
        id: "",
        name: name,
        image: image,
        banner: banner,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/categories"),
        body: category.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHtppResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Upload Category');
        },
      );
    } catch (e) {
      print('Error to uploading to cloudanary: $e');
    }
  }

  Future<List<Category>> loadCategories() async {
    try {
      // send an http get request to load the categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/categories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        List<Category> categories =
            data.map((category) => Category.fromJson(category)).toList();
        return categories;
      } else {
        throw Exception("Failed to load categoryImage");
      }
    } catch (e) {
      throw Exception("Error to loading categories $e");
    }
  }
}
