import 'dart:developer';
import 'dart:ui' show PlatformDispatcher;

import 'package:Fluxx/themes/app_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'theme_state.dart';

/// Guarda a escolha de tema do usuário e mantém [AppTheme] em sincronia com ela.
///
/// Toda mudança de estado reaplica o brilho em [AppTheme] antes do `emit`, para
/// que o rebuild disparado pelo estado novo já leia a paleta certa.
class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit()
      : super(ThemeState(
          platformBrightness:
              PlatformDispatcher.instance.platformBrightness,
        ));

  static const _storageKey = 'theme_mode';

  /// Lê a preferência salva. Deve rodar antes do primeiro frame.
  Future<void> load() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      _apply(state.copyWith(
        mode: AppThemeMode.fromStorage(prefs.getString(_storageKey)),
      ));
    } catch (e) {
      // Sem preferência legível o app abre acompanhando o sistema.
      log('$e', name: 'ThemeCubit.load');
      _apply(state);
    }
  }

  Future<void> setMode(AppThemeMode mode) async {
    if (mode == state.mode) return;

    _apply(state.copyWith(mode: mode));

    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, mode.name);
    } catch (e) {
      // A troca vale para esta sessão mesmo se a gravação falhar.
      log('$e', name: 'ThemeCubit.setMode');
    }
  }

  /// Chamado quando o sistema troca de claro para escuro, ou vice-versa.
  void updatePlatformBrightness(Brightness brightness) {
    if (brightness == state.platformBrightness) return;
    _apply(state.copyWith(platformBrightness: brightness));
  }

  void _apply(ThemeState next) {
    AppTheme.setBrightness(next.brightness);
    emit(next);
  }
}
