import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/enums/view_state.dart';
import 'package:mvvm_evaluation_task/core/models/users_reponse_model.dart';
import 'package:mvvm_evaluation_task/core/repositories/api_repository.dart';
import 'package:mvvm_evaluation_task/core/view_model/base_model.dart';

class HomeViewModel extends BaseModel {
  List<ResponseModel> doctorData = [];

  final ApiRepository _apiRepository = ApiRepository();

  Future<void> getData(BuildContext context, int currentPage) async {
    final response = await _apiRepository.getData(currentPage);
    state = ViewState.busy;
    try {
      state = ViewState.idle;
      final responseData = response.data;
      final List<dynamic> dataList = responseData['data'];
      if (responseData == null) {
        log("No data present");
      }
      final List<ResponseModel> newData = dataList.map((e) {
        return ResponseModel.fromJson(e);
      }).toList();
      doctorData.addAll(newData);
    } on DioException catch (e) {
      if (e.response != null) {
        if (e.response?.statusCode.toString().startsWith("5") == true) {
          state = ViewState.idle;
        }
      }
      e.response != null
          ? log(e.response!.data["message"].toString())
          : log(e.message ?? "");
      state = ViewState.idle;
    } catch (e) {
      log('Error fetching data: $e');
      state = ViewState.error;
    }
  }
}
