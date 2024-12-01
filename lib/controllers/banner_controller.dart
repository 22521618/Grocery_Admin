import 'dart:convert';

import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:grocery_web/global_variable.dart';
import 'package:grocery_web/models/banner.dart';
import 'package:grocery_web/services/manage_http_response.dart';
import 'package:http/http.dart' as http;

class BannerController {
  uploadBanner({
    required dynamic pickedImage,
    required context,
  }) async {
    try {
      final cloudinary = CloudinaryPublic("dwrchdx6d", 'rietpo2b');

      //upload the image
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage,
            identifier: 'pickedImage', folder: 'banners'),
      );
      String image = imageResponse.secureUrl;

      BannerModel bannerModel = BannerModel(id: '', image: image);

      http.Response response = await http.post(
        Uri.parse("$uri/api/banner"),
        body: bannerModel.toJson(),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8"
        },
      );

      manageHtppResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Upload Banner');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  Future<List<BannerModel>> loadBanners() async {
    try {
      http.Response response = await http.get(
        Uri.parse('$uri/api/banner'),
        headers: <String, String>{
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        List<dynamic> data = jsonDecode(response.body);
        List<BannerModel> banners =
            data.map((banner) => BannerModel.fromJson(banner)).toList();
        return banners;
      } else {
        throw Exception("Failed to load bannerImage");
      }
    } catch (e) {
      throw Exception("Error to loading banners $e");
    }
  }
}
