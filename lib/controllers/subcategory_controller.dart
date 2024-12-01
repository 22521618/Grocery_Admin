import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/subcategory.dart';
import 'package:grocery_web/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubcategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subcategoryName,
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

      Subcategory subcategory = Subcategory(
        id: '',
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subcategoryName,
      );

      http.Response response = await http.post(
        Uri.parse("$uri/api/subcategories"),
        body: subcategory.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHtppResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Upload subcategory');
        },
      );
    } catch (e) {}
  }

  Future<List<Subcategory>> loadSubategories() async {
    try {
      // send an http get request to load the categories
      http.Response response = await http.get(
        Uri.parse('$uri/api/subcategories'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);

        List<Subcategory> subcategories =
            data.map((category) => Subcategory.fromJson(category)).toList();
        return subcategories;
      } else {
        throw Exception("Failed to load categoryImage");
      }
    } catch (e) {
      throw Exception("Error to loading categories $e");
    }
  }
}
