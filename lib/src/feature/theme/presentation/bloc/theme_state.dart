part of 'theme_bloc.dart';

@immutable
sealed class ThemeState {}

final class ThemeInitial extends ThemeState {
  ThemeInitial({required this.mode});

  final ThemeMode mode;
}
