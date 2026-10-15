import 'package:Fluxx/blocs/theme_cubit/theme_cubit.dart';
import 'package:Fluxx/themes/app_theme.dart';
import 'package:Fluxx/utils/setup_dependences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() async {
    await GetIt.I.reset();
    SharedPreferences.setMockInitialValues({});
  });

  tearDown(() => AppTheme.setBrightness(Brightness.dark));

  group('bootstrap do app', () {
    test('setupDependencies registra o ThemeCubit', () {
      setupDependencies();

      expect(GetIt.I.isRegistered<ThemeCubit>(), isTrue);
    });

    // Espelha a ordem do main(): o tema precisa estar aplicado antes do
    // primeiro frame, senão o app pisca no modo errado ao abrir.
    test('o tema salvo já está aplicado quando o app começa a construir',
        () async {
      SharedPreferences.setMockInitialValues({'theme_mode': 'light'});
      setupDependencies();

      await GetIt.I<ThemeCubit>().load();

      expect(AppTheme.brightness, Brightness.light);
      expect(AppTheme.colors.appBackgroundColor, const Color(0xFFF7F8FA));
    });
  });
}
