// ignore_for_file: depend_on_referenced_packages

import 'dart:io';
import 'package:amazon/common/widgets/custom_button.dart';
import 'package:amazon/common/widgets/custom_textfield.dart';
import 'package:amazon/constants/utils.dart';
import 'package:amazon/features/admin/services/admin_services.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../constants/global_variables.dart';
import 'package:dotted_border/dotted_border.dart';

class AddProduct extends StatefulWidget {
  static const String routeName = '/add-product';
  const AddProduct({super.key});
  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final TextEditingController productNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  List<String> productCategories = [
    'Select Category',
    'Mobiles',
    'Essentails',
    'Appliances',
    'Books',
    'Fashion'
  ];

  List<File> images = [];
  final addProductFormKey = GlobalKey<FormState>();

  String category = 'Select Category';
  @override
  void dispose() {
    productNameController.dispose();
    quantityController.dispose();
    descriptionController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void selectImages() async {
    var res = await picImages();
    setState(() {
      images = res;
    });
  }

  void sellProduct() {
    if (addProductFormKey.currentState!.validate() && images.isNotEmpty) {
      AdminServices().sellProducts(
          context: context,
          name: productNameController.text,
          category: category,
          description: descriptionController.text,
          price: double.parse(priceController.text),
          quantity: double.parse(quantityController.text),
          images: images);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: AppBar(
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              gradient: GlobalVariables.appBarGradient,
            ),
          ),
          centerTitle: true,
          title: const Text(
            "Add Product",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
            key: addProductFormKey,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Column(
                children: [
                  images.isNotEmpty
                      ? CarouselSlider(
                          items: images.map((e) {
                            return Builder(
                              builder: (context) {
                                return Image.file(
                                  e,
                                  fit: BoxFit.cover,
                                  height: 200,
                                );
                              },
                            );
                          }).toList(),
                          options:
                              CarouselOptions(viewportFraction: 1, height: 200),
                        )
                      : GestureDetector(
                          onTap: () {
                            selectImages();
                          },
                          child: DottedBorder(
                            borderType: BorderType.RRect,
                            radius: const Radius.circular(10),
                            dashPattern: const [10, 4],
                            child: Container(
                              width: double.infinity,
                              height: 150,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: const [
                                  Icon(
                                    Icons.folder_open,
                                    size: 30,
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  Text(
                                    'Select product Images',
                                    style: TextStyle(
                                        fontSize: 15,
                                        color: Colors.black38,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextfield(
                      controller: productNameController,
                      hintText: "Product name"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                      controller: descriptionController,
                      hintText: "Description",
                      maxLines: 5),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                      controller: priceController, hintText: "Product price"),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                      controller: quantityController,
                      hintText: "Product quanPtity"),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: DropdownButton(
                      value: category,
                      icon: const Icon(Icons.keyboard_arrow_down),
                      items: productCategories.map((String item) {
                        return DropdownMenuItem(value: item, child: Text(item));
                      }).toList(),
                      onChanged: (String? value) {
                        setState(() {
                          category = value!;
                        });
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 50,
                    child: CustomButton(
                        text: "Sell",
                        onTap: () {
                          sellProduct();
                        }),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
