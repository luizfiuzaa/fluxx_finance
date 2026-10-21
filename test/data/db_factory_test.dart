import 'dart:io';

import 'package:Fluxx/data/db_factory/db_factory.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('initDatabaseFactory no desktop', () {
    test('abre, escreve e lê um banco pelo SQLite nativo', () async {
      if (!Platform.isWindows && !Platform.isLinux) {
        markTestSkipped('só vale no desktop sem sqflite nativo');
        return;
      }

      await initDatabaseFactory();

      final db = await databaseFactory.openDatabase(inMemoryDatabasePath);
      addTearDown(db.close);

      await db.execute('CREATE TABLE t (id INTEGER PRIMARY KEY, nome TEXT)');
      await db.insert('t', {'id': 1, 'nome': 'conta'});

      expect(await db.query('t'), [
        {'id': 1, 'nome': 'conta'}
      ]);
    });

    test('mantém a implementação nativa no Android, iOS e macOS', () async {
      if (Platform.isWindows || Platform.isLinux) {
        markTestSkipped('este caso cobre as plataformas com sqflite nativo');
        return;
      }

      final before = databaseFactory;

      await initDatabaseFactory();

      expect(databaseFactory, same(before));
    });
  });
}
