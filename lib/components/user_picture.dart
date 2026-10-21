/// Carrega a foto escolhida pelo usuário.
///
/// O caminho que o image_picker devolve é um arquivo no disco nas plataformas
/// nativas e uma URL de blob no navegador, então cada plataforma precisa de um
/// widget de imagem diferente.
library;

export 'user_picture_io.dart'
    if (dart.library.js_interop) 'user_picture_web.dart';
