import 'package:Fluxx/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  tearDown(() => AppTheme.setBrightness(Brightness.dark));

  group('AppTheme.colors', () {
    test('devolve a paleta escura por padrão', () {
      AppTheme.setBrightness(Brightness.dark);

      expect(AppTheme.colors.appBackgroundColor, const Color(0xFF121212));
      expect(AppTheme.colors.itemBackgroundColor, const Color(0xFF1E1E1E));
      expect(AppTheme.colors.primaryTextColor, const Color(0xFFD9D9D9));
    });

    test('troca para a paleta clara quando o brilho muda', () {
      AppTheme.setBrightness(Brightness.light);

      expect(AppTheme.colors.appBackgroundColor, const Color(0xFFF7F8FA));
      expect(AppTheme.colors.itemBackgroundColor, const Color(0xFFFFFFFF));
      expect(AppTheme.colors.primaryTextColor, const Color(0xFF1A1A1A));
    });

    test('mantém o azul da marca nos dois modos', () {
      AppTheme.setBrightness(Brightness.dark);
      final darkHint = AppTheme.colors.hintColor;

      AppTheme.setBrightness(Brightness.light);

      expect(AppTheme.colors.hintColor, darkHint);
    });

    test('expõe instâncias diferentes para cada brilho', () {
      AppTheme.setBrightness(Brightness.dark);
      final dark = AppTheme.colors;

      AppTheme.setBrightness(Brightness.light);

      expect(identical(AppTheme.colors, dark), isFalse);
    });

    test('todo token tem um valor distinto nas duas paletas, exceto os literais', () {
      AppTheme.setBrightness(Brightness.dark);
      final dark = _tokens(AppTheme.colors);

      AppTheme.setBrightness(Brightness.light);
      final light = _tokens(AppTheme.colors);

      // Tokens propositalmente iguais nos dois modos: literais e cor de marca.
      const shared = {'transparent', 'white', 'black', 'grayD4', 'hintColor', 'onHintColor'};

      for (final name in dark.keys) {
        if (shared.contains(name)) {
          expect(light[name], dark[name], reason: '$name deveria ser igual nos dois modos');
        } else {
          expect(light[name], isNot(dark[name]), reason: '$name não foi adaptado para o modo claro');
        }
      }
    });
  });

  group('AppTheme.themeData', () {
    test('acompanha o brilho ativo', () {
      AppTheme.setBrightness(Brightness.light);
      expect(AppTheme.themeData.brightness, Brightness.light);

      AppTheme.setBrightness(Brightness.dark);
      expect(AppTheme.themeData.brightness, Brightness.dark);
    });
  });

  group('AppTheme.textStyles', () {
    test('as cores de texto seguem a paleta ativa', () {
      AppTheme.setBrightness(Brightness.dark);
      final darkBody = AppTheme.textStyles.bodyTextStyle.color;

      AppTheme.setBrightness(Brightness.light);

      expect(AppTheme.textStyles.bodyTextStyle.color, isNot(darkBody));
      expect(AppTheme.textStyles.bodyTextStyle.color, AppTheme.colors.primaryTextColor);
    });
  });
}

Map<String, Color> _tokens(ColorsInterface c) => {
      'appBackgroundColor': c.appBackgroundColor,
      'itemBackgroundColor': c.itemBackgroundColor,
      'accentSurfaceColor': c.accentSurfaceColor,
      'hintColor': c.hintColor,
      'lightHintColor': c.lightHintColor,
      'onHintColor': c.onHintColor,
      'transparent': c.transparent,
      'primaryTextColor': c.primaryTextColor,
      'hintTextColor': c.hintTextColor,
      'borderColor': c.borderColor,
      'shadowColor': c.shadowColor,
      'grayD4': c.grayD4,
      'white': c.white,
      'black': c.black,
      'red': c.red,
    };
