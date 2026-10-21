import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// Instala o SQLite compilado para WebAssembly.
///
/// Depende de dois arquivos em `web/`, gerados por
/// `dart run sqflite_common_ffi_web:setup`: o worker `sqflite_sw.js` e o
/// binário `sqlite3.wasm`. Os dados ficam no IndexedDB do navegador, então
/// cada navegador tem seu próprio banco.
Future<void> initDatabaseFactory() async {
  databaseFactory = databaseFactoryFfiWeb;
}
