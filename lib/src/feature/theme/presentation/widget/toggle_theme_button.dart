import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tmdp_movie_app/src/feature/theme/presentation/bloc/theme_bloc.dart';

class ToggleThemeButton extends StatelessWidget {
  const ToggleThemeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        switch (state) {
          case ThemeInitial():
            return IconButton(
              onPressed: () =>
                  context.read<ThemeBloc>().add(ChangeThemeEvent()),
              icon: Icon(
                state.mode == ThemeMode.light
                    ? Icons.dark_mode
                    : Icons.light_mode_outlined,
              ),
            );
        }
      },
    );
  }
}
