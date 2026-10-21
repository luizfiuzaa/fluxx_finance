/// Escolhe a implementação do sqflite conforme a plataforma.
///
/// O sqflite só traz implementação nativa para Android, iOS e macOS. Em
/// Windows, Linux e no navegador é preciso instalar uma fábrica antes do
/// primeiro acesso ao banco, senão `getDatabasesPath()` estoura e o app para
/// na tela de abertura.
library;

export 'db_factory_io.dart'
    if (dart.library.js_interop) 'db_factory_web.dart';
