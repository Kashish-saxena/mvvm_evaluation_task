import 'dart:developer';
import 'package:dio/dio.dart';

class ApiRepository {
  static Dio dio = Dio();

  //get api service
  Future getData(int currentPage) async {
    Response response;
    try {
      response = await dio.get(
        "https://reqres.in/api/users?page=$currentPage",
      );
      return response;
    } catch (e) {
      log('Error in fetching data $e');
    }
  }
}
