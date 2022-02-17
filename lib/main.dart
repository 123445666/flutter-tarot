import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'src/pages/home_page.dart';
import 'package:vuabian/src/providers/all_deck.dart';
import 'package:vuabian/src/providers/interstitial_counter.dart';
import 'src/providers/current_index.dart';

// INTERNATIONALIZATION
import 'package:vuabian/generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => CurrentIndexProvider(),
        ),
        ChangeNotifierProvider(
          create: (_) => AllDeck(),
        ),
        ChangeNotifierProvider(
          create: (_) => InterstitialCounter(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/home': (context) => const MyHomePage(),
      },
      title: 'Material App',
      home: const MyHomePage(),
      // PlanetarySpreadPage(),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
    );
  }
}




