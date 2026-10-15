import 'package:Fluxx/blocs/theme_cubit/theme_cubit.dart';
import 'package:Fluxx/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));
  tearDown(() => AppTheme.setBrightness(Brightness.dark));

  group('ThemeState.brightness', () {
    test('segue o sistema no modo system', () {
      const state = ThemeState(
        mode: AppThemeMode.system,
        platformBrightness: Brightness.light,
      );

      expect(state.brightness, Brightness.light);
    });

    test('ignora o sistema quando o modo é fixo', () {
      const state = ThemeState(
        mode: AppThemeMode.dark,
        platformBrightness: Brightness.light,
      );

      expect(state.brightness, Brightness.dark);
    });
  });

  group('ThemeCubit.load', () {
    test('sem preferência salva, começa seguindo o sistema', () async {
      final cubit = ThemeCubit();

      await cubit.load();

      expect(cubit.state.mode, AppThemeMode.system);
    });

    test('restaura o modo salvo', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
      final cubit = ThemeCubit();

      await cubit.load();

      expect(cubit.state.mode, AppThemeMode.light);
      expect(AppTheme.colors.appBackgroundColor, const Color(0xFFF7F8FA));
    });

    test('valor inválido salvo cai no padrão em vez de quebrar', () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'sepia'});
      final cubit = ThemeCubit();

      await cubit.load();

      expect(cubit.state.mode, AppThemeMode.system);
    });
  });

  group('ThemeCubit.setMode', () {
    test('aplica a paleta e persiste a escolha', () async {
      final cubit = ThemeCubit();
      await cubit.load();

      await cubit.setMode(AppThemeMode.light);

      expect(AppTheme.colors.appBackgroundColor, const Color(0xFFF7F8FA));

      final prefs = await SharedPreferences.getInstance();
      expect(prefs.getString('theme_mode'), 'light');
    });

    test('a escolha sobrevive a um novo cubit', () async {
      final cubit = ThemeCubit();
      await cubit.load();
      await cubit.setMode(AppThemeMode.dark);

      final restored = ThemeCubit();
      await restored.load();

      expect(restored.state.mode, AppThemeMode.dark);
    });
  });

  group('ThemeCubit.updatePlatformBrightness', () {
    test('troca a paleta quando o modo é system', () async {
      final cubit = ThemeCubit();
      await cubit.load();

      cubit.updatePlatformBrightness(Brightness.light);

      expect(cubit.state.brightness, Brightness.light);
      expect(AppTheme.colors.appBackgroundColor, const Color(0xFFF7F8FA));
    });

    test('não afeta a paleta quando o modo é fixo', () async {
      final cubit = ThemeCubit();
      await cubit.load();
      await cubit.setMode(AppThemeMode.dark);

      cubit.updatePlatformBrightness(Brightness.light);

      expect(cubit.state.brightness, Brightness.dark);
      expect(AppTheme.colors.appBackgroundColor, const Color(0xFF121212));
    });
  });
}
