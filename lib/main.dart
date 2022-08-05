import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/CurrentIndexProvider.dart';
import 'routes/routes.dart';
import 'utils/Global.dart';

void main() {
  FluroRouter router = FluroRouter();
  Routes.configureRoutes(router);
  G.router = router;
  runApp(MultiProvider(
      providers: [ChangeNotifierProvider.value(value: CurrentIndexProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: IndexPage(),
      onGenerateRoute: G.router.generator,
      initialRoute: '/',
    );
  }
}
