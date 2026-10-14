import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

part 'colors.dart';
part 'text_styles.dart';
part 'font_sizes.dart';

/// Ponto único de acesso ao tema.
///
/// [colors] devolve a paleta do brilho ativo, então as telas continuam lendo
/// `AppTheme.colors.x` sem saber qual modo está ligado. Quem troca o brilho é
/// o `ThemeCubit`; depois de [setBrightness] a árvore precisa ser reconstruída.
class AppTheme {
  static Brightness _brightness = Brightness.dark;

  static Brightness get brightness => _brightness;

  static void setBrightness(Brightness brightness) {
    _brightness = brightness;
  }

  static bool get isDark => _brightness == Brightness.dark;

  static ColorsInterface get colors => isDark ? _DarkColors() : _LightColors();
  static TextStylesInterface get textStyles => _DefaultTextStyles();
  static FontSizesInterface get fontSizes => _DefaultFontSizes();

  /// Ícones da barra de status legíveis sobre [ColorsInterface.appBackgroundColor].
  static SystemUiOverlayStyle get overlayStyle =>
      isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark;

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      brightness: _brightness,
      fontFamily: "Inter",
      primaryColor: colors.hintColor,
      dividerColor: colors.borderColor,
      scaffoldBackgroundColor: colors.appBackgroundColor,
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: colors.hintColor,
        selectionColor: colors.hintColor,
        selectionHandleColor: colors.hintColor,
      ),
    );
  }
}
