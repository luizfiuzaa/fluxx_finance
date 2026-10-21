/// Reconhece falhas de rede de baixo nível.
///
/// No VM elas chegam como `IOException` (socket, DNS, TLS); no navegador esse
/// tipo não existe e o `package:http` já entrega tudo como `ClientException`.
library;

export 'network_error_io.dart'
    if (dart.library.js_interop) 'network_error_web.dart';
