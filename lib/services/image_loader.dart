import 'package:flutter/material.dart';

Widget ImageLoader(String url) {
  try {
    return Image.network(
      url,
      fit: BoxFit.cover,
    );
  } catch (e) {
    return const Icon(Icons.image);
  }
}
