import 'dart:io';

import 'package:flutter/material.dart';

Widget userPicture({required String path, required Widget fallback}) {
  return Image.file(
    File(path),
    fit: BoxFit.cover,
    errorBuilder: (context, error, stackTrace) => fallback,
  );
}
