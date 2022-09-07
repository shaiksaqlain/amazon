// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:amazon/constants/error_handling.dart';
import 'package:amazon/constants/global_variables.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/admin/model/product.dart';
import 'package:amazon/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class AdminServices {
  void sellProducts({
    required BuildContext context,
    required String name,
    required String description,
    required double quantity,
    required double price,
    required String category,
    required List<File> images,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      final cloudinary = CloudinaryPublic('do2zg7nuf', 'gbzfbvkb');
      List<String> imageUrls = [];
      for (var i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary
            .uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imageUrls.add(res.secureUrl);
      }

      Product product = Product(
        name: name,
        description: description,
        quantity: quantity,
        images: imageUrls,
        category: category,
        price: price,
      );
      http.Response res = await http.post(
        Uri.parse('$uri/admin/add-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: product.toJson(),
      );
      httpErrorHandleFunctions(
        response: res,
        context: context,
        onSuccess: () {
          showSnackbar(context, "Product added successfully");
          Navigator.of(context).pop();
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/admin/get-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
      );

      httpErrorHandleFunctions(
        response: res,
        context: context,
        onSuccess: () {
          for (var i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(jsonDecode(res.body)[i]),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }

  void deleteProduct(
      {required BuildContext context,
      required Product product,
      required VoidCallback onSuccess}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/admin/delete-product'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'id': product.id,
        }),
      );
      httpErrorHandleFunctions(
        response: res,
        context: context,
        onSuccess: () {
          onSuccess();
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
