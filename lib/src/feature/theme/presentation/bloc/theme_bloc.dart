import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends HydratedBloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(ThemeInitial(mode: ThemeMode.light)) {
    on<ChangeThemeEvent>((event, emit) => toggleDarkMode(emit));
  }

  /// theme mode controller
  ThemeMode appThemeMode = ThemeMode.light;

  /// switch current app theme
  void toggleDarkMode(Emitter emit) {
    if (appThemeMode == ThemeMode.light) {
      appThemeMode = ThemeMode.dark;
    } else {
      appThemeMode = ThemeMode.light;
    }
    emit(ThemeInitial(mode: appThemeMode));
  }

  @override
  ThemeState? fromJson(Map<String, dynamic> json) {
    return ThemeInitial(
      mode: ThemeMode.values[json['theme_mode']],
    );
  }

  @override
  Map<String, dynamic>? toJson(ThemeState state) {
    switch (state) {
      case ThemeInitial():
        return {
          'theme_mode': state.mode.index,
        };
    }
  }
}
