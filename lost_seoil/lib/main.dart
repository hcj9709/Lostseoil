import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:lost_seoil/Dialog/dialog.dart';
import 'package:lost_seoil/Dialog/timesetdialog.dart';
import 'package:lost_seoil/login/login_page.dart';
import 'package:lost_seoil/mainform/lostseoild_mainform.dart';
import 'package:lost_seoil/menu/menu_drawer.dart';

import 'mainform/testform.dart';
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
       home:MyTest()
      ),
  );
}
