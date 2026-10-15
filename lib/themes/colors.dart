part of 'app_theme.dart';

abstract class ColorsInterface {
  /// Fundo das telas.
  Color get appBackgroundColor;

  /// Fundo de cards, listas e bottom sheets, um degrau acima do fundo da tela.
  Color get itemBackgroundColor;

  /// Superfície de destaque: cabeçalho do drawer, tiles de ícone.
  Color get accentSurfaceColor;

  /// Azul da marca. Igual nos dois modos.
  Color get hintColor;

  /// Variação do azul para texto e ícones secundários.
  Color get lightHintColor;

  /// Conteúdo desenhado por cima de [hintColor].
  Color get onHintColor;

  Color get transparent;

  /// Texto principal.
  Color get primaryTextColor;

  /// Texto secundário, placeholders e ícones apagados.
  Color get hintTextColor;

  /// Bordas e divisores.
  Color get borderColor;

  /// Sombras, já com a opacidade embutida.
  Color get shadowColor;

  Color get grayD4;
  Color get white;
  Color get black;

  /// Erros e ações destrutivas.
  Color get red;
}

class _DarkColors implements ColorsInterface {
  _DarkColors._internal();

  static final _DarkColors _singleton = _DarkColors._internal();

  factory _DarkColors() {
    return _singleton;
  }

  @override
  Color get appBackgroundColor => const Color(0xFF121212);
  @override
  Color get itemBackgroundColor => const Color(0xFF1E1E1E);
  @override
  Color get accentSurfaceColor => const Color(0xFF0B2A4A);
  @override
  Color get hintColor => const Color(0xFF0077FF);
  @override
  Color get lightHintColor => const Color(0xFF5BA7FF);
  @override
  Color get onHintColor => const Color(0xFFFFFFFF);
  @override
  Color get transparent => Colors.transparent;
  @override
  Color get primaryTextColor => const Color(0xffD9D9D9);
  @override
  Color get hintTextColor => const Color(0xff8C8C8C);
  @override
  Color get borderColor => const Color(0xFF2E2E2E);
  @override
  Color get shadowColor => const Color(0x66000000);
  @override
  Color get grayD4 => const Color(0xffd4d4d4);
  @override
  Color get white => const Color(0xffffffff);
  @override
  Color get black => const Color(0xff000000);
  @override
  Color get red => const Color(0xffff4242);
}

class _LightColors implements ColorsInterface {
  _LightColors._internal();

  static final _LightColors _singleton = _LightColors._internal();

  factory _LightColors() {
    return _singleton;
  }

  @override
  Color get appBackgroundColor => const Color(0xFFF7F8FA);
  @override
  Color get itemBackgroundColor => const Color(0xFFFFFFFF);
  @override
  Color get accentSurfaceColor => const Color(0xFFE3F0FF);
  @override
  Color get hintColor => const Color(0xFF0077FF);
  // Mais escuro que o equivalente do modo escuro: #5BA7FF não tem contraste
  // suficiente sobre fundo claro.
  @override
  Color get lightHintColor => const Color(0xFF2B7FD9);
  @override
  Color get onHintColor => const Color(0xFFFFFFFF);
  @override
  Color get transparent => Colors.transparent;
  @override
  Color get primaryTextColor => const Color(0xFF1A1A1A);
  @override
  Color get hintTextColor => const Color(0xFF6B7280);
  @override
  Color get borderColor => const Color(0xFFE4E7EC);
  @override
  Color get shadowColor => const Color(0x1A101828);
  @override
  Color get grayD4 => const Color(0xffd4d4d4);
  @override
  Color get white => const Color(0xffffffff);
  @override
  Color get black => const Color(0xff000000);
  @override
  Color get red => const Color(0xFFE02B2B);
}
