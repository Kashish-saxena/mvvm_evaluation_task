import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/models/users_reponse_model.dart';
import 'package:mvvm_evaluation_task/core/routing/routes.dart';
import 'package:mvvm_evaluation_task/ui/views/doctor_screen.dart';
import 'package:mvvm_evaluation_task/ui/views/home_screeen.dart';

class PageRoutes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (context) => HomeScreen());
      case Routes.doctorScreen:
        ResponseModel responseModel = settings.arguments as ResponseModel;
        return MaterialPageRoute(builder: (context) => DoctorScreen(arguments:responseModel));

      default:
        return MaterialPageRoute(
            builder: (context) => const Text("No Page exists..."));
    }
  }
}
