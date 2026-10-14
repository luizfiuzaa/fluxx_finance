import 'package:Fluxx/blocs/theme_cubit/theme_cubit.dart';
import 'package:Fluxx/themes/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

/// Abre o seletor de tema e aplica a escolha.
Future<void> showThemeBottomsheet(BuildContext context) async {
  final mode = await showModalBottomSheet<AppThemeMode>(
    context: context,
    backgroundColor: AppTheme.colors.transparent,
    builder: (context) => const ThemeBottomsheet(),
  );

  if (mode == null) return;

  await GetIt.I<ThemeCubit>().setMode(mode);
}

class ThemeBottomsheet extends StatelessWidget {
  const ThemeBottomsheet({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeCubit, ThemeState>(
      bloc: GetIt.I(),
      builder: (context, state) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        decoration: BoxDecoration(
          color: AppTheme.colors.itemBackgroundColor,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Tema do aplicativo',
                style: AppTheme.textStyles.bodyTextStyle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              _ThemeTile(
                icon: Icons.brightness_auto_rounded,
                title: 'Automático',
                subtitle: 'Acompanha o sistema',
                mode: AppThemeMode.system,
                isSelected: state.mode == AppThemeMode.system,
              ),
              const SizedBox(height: 12),
              _ThemeTile(
                icon: Icons.light_mode_rounded,
                title: 'Claro',
                subtitle: 'Fundo claro o tempo todo',
                mode: AppThemeMode.light,
                isSelected: state.mode == AppThemeMode.light,
              ),
              const SizedBox(height: 12),
              _ThemeTile(
                icon: Icons.dark_mode_rounded,
                title: 'Escuro',
                subtitle: 'Fundo escuro o tempo todo',
                mode: AppThemeMode.dark,
                isSelected: state.mode == AppThemeMode.dark,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ThemeTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final AppThemeMode mode;
  final bool isSelected;

  const _ThemeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.mode,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => Navigator.pop(context, mode),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppTheme.colors.appBackgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: isSelected
                ? AppTheme.colors.hintColor
                : AppTheme.colors.borderColor,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: AppTheme.colors.hintColor.withAlpha(50),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: AppTheme.colors.hintColor),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTheme.textStyles.bodyTextStyle),
                  const SizedBox(height: 2),
                  Text(subtitle, style: AppTheme.textStyles.secondaryTextStyle),
                ],
              ),
            ),
            if (isSelected)
              Icon(Icons.check_rounded, color: AppTheme.colors.hintColor),
          ],
        ),
      ),
    );
  }
}
