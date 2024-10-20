import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:tmdp_movie_app/src/core/constants/const_config.dart';
import 'package:tmdp_movie_app/src/core/di/di_manager.dart';
import 'package:tmdp_movie_app/src/feature/home/domain/repository/movies_repository.dart';
import 'package:tmdp_movie_app/src/feature/home/presentation/screen/movies_home_screen.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DIManager.initAppInjections();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: kIsWeb
        ? HydratedStorage.webStorageDirectory
        : await getApplicationDocumentsDirectory(),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: ConstConfig.appName,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MoviesHomeScreen(
        moviesRepository: DIManager.getIt<MoviesRepository>(),
      ),
    );
  }
}
