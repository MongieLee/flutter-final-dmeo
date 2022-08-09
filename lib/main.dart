import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/CurrentIndexProvider.dart';
import 'providers/UserProvider.dart';
import 'routes/routes.dart';
import 'utils/Global.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  G.router = router;
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider.value(value: CurrentIndexProvider()),
    ChangeNotifierProvider.value(value: UserProvider()),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(750, 1334),
        builder: (context, child) => MaterialApp(
              navigatorKey: G.navigatorKey,
              title: 'Flutter Demo',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              // home: IndexPage(),
              onGenerateRoute: G.router.generator,
              initialRoute: '/',
            ));
  }
}
