// ignore_for_file: depend_on_referenced_packages

import 'package:amazon/constants/global_variables.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarousalImage extends StatefulWidget {
  const CarousalImage({Key? key}) : super(key: key);

  @override
  State<CarousalImage> createState() => _CarousalImageState();
}

class _CarousalImageState extends State<CarousalImage> {
  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      items: GlobalVariables.carouselImages.map((e) {
        return Builder(
          builder: (context) {
            return Image.network(
              e,
              fit: BoxFit.cover,
              height: 200,
            );
          },
        );
      }).toList(),
      options: CarouselOptions(viewportFraction: 1, height: 200),
    );
  }
}
