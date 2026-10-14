part of 'theme_cubit.dart';

enum AppThemeMode {
  /// Acompanha o brilho do sistema operacional.
  system,
  light,
  dark;

  static AppThemeMode fromStorage(String? value) {
    return AppThemeMode.values.firstWhere(
      (mode) => mode.name == value,
      // Preferência ausente ou gravada por uma versão com outros valores.
      orElse: () => AppThemeMode.system,
    );
  }
}

class ThemeState extends Equatable {
  final AppThemeMode mode;

  /// Último brilho informado pelo sistema. Só importa no modo [AppThemeMode.system].
  final Brightness platformBrightness;

  const ThemeState({
    this.mode = AppThemeMode.system,
    this.platformBrightness = Brightness.dark,
  });

  Brightness get brightness => switch (mode) {
        AppThemeMode.system => platformBrightness,
        AppThemeMode.light => Brightness.light,
        AppThemeMode.dark => Brightness.dark,
      };

  ThemeState copyWith({AppThemeMode? mode, Brightness? platformBrightness}) {
    return ThemeState(
      mode: mode ?? this.mode,
      platformBrightness: platformBrightness ?? this.platformBrightness,
    );
  }

  @override
  List<Object?> get props => [mode, platformBrightness];
}
