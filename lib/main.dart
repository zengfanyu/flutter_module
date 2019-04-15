import 'dart:ui';

import 'package:flutter/material.dart';
import 'daily/daily_page.dart';

void main() => runApp(_widgetForRoute(window.defaultRouteName));

Widget _widgetForRoute(String route) {
  switch (route) {
    case 'NativeFlutter':
      return MaterialApp(
        title: 'NativeFlutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DailyPage(title: 'NativeFlutter', isShowToolBar: false),
      );
    default:
      return MaterialApp(
        title: 'Flutter',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: DailyPage(title: 'Flutter',isShowToolBar: true),
      );
  }
}
