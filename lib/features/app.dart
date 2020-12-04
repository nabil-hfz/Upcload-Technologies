import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:upcload_technology/core/bloc/application_bloc.dart';
import 'package:upcload_technology/core/bloc/application_events.dart';
import 'package:upcload_technology/core/bloc/application_state.dart';
import 'package:upcload_technology/core/localization/specific_localization_delegate.dart';
import 'package:upcload_technology/core/localization/translations_delegate.dart';
import 'package:upcload_technology/core/resources/global_color.dart';
import 'package:upcload_technology/core/utils/utils.dart';
import 'package:upcload_technology/features/task_1/presentation/screens/google_map_screen.dart';
import 'package:upcload_technology/features/task_2/screens/animated_screen.dart';

import 'middle_screen.dart';

class MyApp extends StatelessWidget {
  final String lang;

  const MyApp({this.lang});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      child: Builder(builder: (context) {
        return BlocBuilder<ApplicationBloc, ApplicationState>(
          bloc: BlocProvider.of<ApplicationBloc>(context),
          builder: (context, state) {
            print(
                "===== Application Language ===== ${state.language} ===============");

            final localeOverrideDelegate =
                SpecificLocalizationDelegate(Locale(state.language ?? lang));

            //for insert lang if  you don't use bloc
            utils.setLang(state.language ?? lang);

            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Upcload Technology',
              initialRoute: MiddleScreen.routeName,
              routes: {
                GoogleMapScreen.routeName: (context) => GoogleMapScreen(),
                ShapeAnimatedScreen.routeName: (context) =>
                    ShapeAnimatedScreen(),
                MiddleScreen.routeName: (context) => MiddleScreen(),
                // FormScreen.routeName: (context) => FormScreen(),
                // SheetsListScreen.routeName: (context) => SheetsListScreen(),
              },
              theme: ThemeData(
                primaryColor: globalColor.primary,
                accentColor: globalColor.accentColor,
              ),
              locale: localeOverrideDelegate.overriddenLocale,
              localizationsDelegates: [
                localeOverrideDelegate,
                const TranslationsDelegate(),
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],
              supportedLocales:
                  BlocProvider.of<ApplicationBloc>(context).supportedLocales,
            );
          },
        );
      }),
      providers: [
        BlocProvider<ApplicationBloc>.value(
          value: ApplicationBloc()..add(ApplicationStartedEvent(context)),
        ),
      ],
    );
  }
}
