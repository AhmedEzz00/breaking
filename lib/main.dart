 import 'dart:io';

import 'app_route.dart';
import 'package:flutter/material.dart';


 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
void main() {
  runApp(BreakingBadApp(appRouter: AppRouter(),));
  HttpOverrides.global = MyHttpOverrides();
}

class BreakingBadApp extends StatelessWidget {
  const BreakingBadApp({Key? key,required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: appRouter.generateRoute,
    );
  }
}
