import 'package:domain_package/domain_export.dart';
import 'package:domain_package/enums/environment.dart';
import 'package:flutter/material.dart';
import 'package:jokes_app/screens/joke/joke_list.dart';
import 'package:get/get.dart';

void commonMain(Environment env) async {
  WidgetsFlutterBinding.ensureInitialized();

  /// domain layer
  await DomainLayer.initializeDependencies(env);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    DomainLayer;
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: Scaffold(
        appBar: AppBar(title: const Text('Jokes App')),
        body: JokeListPage(widgetKey: const ValueKey('JokeListPage'), params: {},),
      ),
    );
  }
}
