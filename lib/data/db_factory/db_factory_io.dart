import 'dart:io';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';

/// Instala o SQLite via FFI no desktop.
///
/// Android, iOS e macOS têm implementação nativa e são deixados em paz: trocar
/// a fábrica neles mudaria onde o banco já existente é procurado.
Future<void> initDatabaseFactory() async {
  if (!Platform.isWindows && !Platform.isLinux) return;

  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;
}
