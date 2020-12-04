import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:upcload_technology/core/bloc/simple_bloc_delegate.dart';
import 'package:upcload_technology/core/resources/global_color.dart';
import 'package:upcload_technology/features/app.dart';
import 'package:upcload_technology/features/task_1/data/datasources/concrete_google_map_remote_data_source.dart';
import 'package:upcload_technology/features/task_1/data/repositories/concrete_google_map_repository.dart';
import 'package:uuid/uuid.dart';

import 'core/resources/constants.dart';
import 'core/ui/restart_widget.dart';
import 'features/task_1/data/datasources/google_map_remote_data_source.dart';
import 'features/task_1/domain/repositories/google_map_repository.dart';

final locator = GetIt.instance;
final uuid = Uuid();

void setupLocator() {
  //===================================
  //    Add Google Map Repo
  //===================================

  locator.registerFactory<GoogleMapRemoteDataSource>(
    () => ConcreteGoogleMapRemoteDataSource(),
  );
  locator.registerFactory<GoogleMapRepository>(
    () => ConcreteGoogleMapRepository(locator<GoogleMapRemoteDataSource>()),
  );
}

void setupBloc() {
  BlocSupervisor.delegate = SimpleBlocDelegate();
}

Future<String> _getLanguage() async {
  final prefs = await SharedPreferences.getInstance();
  var lang = prefs.getString(KEY_LANG);
  if (lang == null || lang.isEmpty) {
    await prefs.setString(KEY_LANG, LANG_EN);
    lang = LANG_EN;
  }
  return lang;
}

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
    statusBarColor: globalColor.primary,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();

  String lang = await _getLanguage();

  setupLocator();
  setupBloc();

  runApp(RestartWidget(child: MyApp(lang: lang)));
}
//flutter packages pub run build_runner build --delete-conflicting-outputs
