import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/di/locator.dart';
import 'package:mvvm_evaluation_task/core/routing/router.dart';
import 'package:mvvm_evaluation_task/core/routing/routes.dart';
import 'package:mvvm_evaluation_task/core/view_model/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  setUpLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (context) => HomeViewModel())],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: Routes.homeScreen,
        onGenerateRoute: PageRoutes.generateRoutes,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    );
  }
}
