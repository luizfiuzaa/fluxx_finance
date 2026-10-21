import 'package:flutter/material.dart';

Widget userPicture({required String path, required Widget fallback}) {
  // No navegador o caminho é uma URL de blob criada pelo image_picker.
  return Image.network(
    path,
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) => fallback,
  );
}
