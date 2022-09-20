
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'login/login_page.dart';

void main() {
  runApp(
    const MaterialApp(
        localizationsDelegates: [
          GlobalCupertinoLocalizations.delegate,
          // ... app-specific localization delegate[s] here
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
        ],
        supportedLocales:  [
          Locale('ko', 'KR'), // KOREAN
          // ... other locales the app supports
        ],
        title:'Navigator',
        home:Login_page()
    ),
  );
}
