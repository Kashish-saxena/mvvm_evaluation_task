import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/constants/color_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/image_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/string_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/text_styles.dart';
import 'package:mvvm_evaluation_task/core/models/availabilty_model.dart';
import 'package:mvvm_evaluation_task/core/models/users_reponse_model.dart';
import 'package:mvvm_evaluation_task/core/view_model/doctor_view_model.dart';
import 'package:mvvm_evaluation_task/ui/views/base_view.dart';
import 'package:mvvm_evaluation_task/ui/widgets/navigation_button.dart';
import 'package:mvvm_evaluation_task/ui/widgets/common_button.dart';

// ignore: must_be_immutable
class DoctorScreen extends StatelessWidget {
  DoctorScreen({super.key, required this.responseArguments});
  final ResponseModel responseArguments;
  DoctorViewModel? model;
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return BaseView<DoctorViewModel>(
      onModelReady: (model) {
        this.model = model;
      },
      builder: (context, model, child) {
        return Scaffold(
          body: buildBody(context, model),
        );
      },
    );
  }

  Widget buildBody(context, model) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: Stack(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Image.asset(
                    ImageConstants.appbar,
                    fit: BoxFit.fill,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 60),
                  child: ListTile(
                    dense: true,
                    contentPadding: const EdgeInsets.all(0),
                    leading: BackButtonWidget(
                      onTap: () => Navigator.pop(context),
                    ),
                    title: const Text(
                      StringConstants.chooseAppointment,
                      style: TextStyles.textStyleFont20Weight400,
                    ),
                    trailing: Container(
                      margin: const EdgeInsets.only(right: 15),
                      decoration: BoxDecoration(
                        color: ColorConstants.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.person_2_outlined,
                        color: ColorConstants.amber,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: ColorConstants.grey)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 190,
                  width: 180,
                  child: responseArguments.avatar != null
                      ? Image.network(
                          "${responseArguments.avatar}",
                          fit: BoxFit.fill,
                        )
                      : Image.asset(ImageConstants.profile),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      responseArguments.firstName ?? "",
                      style: const TextStyle(fontSize: 18),
                    ),
                    const Text(StringConstants.dentist),
                    SizedBox(
                      width: 150,
                      height: 30,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return const Icon(
                            Icons.star,
                            color: ColorConstants.amber,
                            size: 20,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availability.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Availability available = availability[index];
                  return buildAppointment(
                      index, available.day, available.availability, model);
                }),
          ),
          const ButtonWidget(
            text: StringConstants.nextAvailability,
            textColor: ColorConstants.white,
            color: ColorConstants.blue,
          ),
          const Text(StringConstants.or),
          const ButtonWidget(
            text: StringConstants.contact,
            textColor: ColorConstants.black,
            color: ColorConstants.white,
          ),
        ],
      ),
    );
  }

  Widget buildAppointment(
      int index, String day, String available, DoctorViewModel model) {
    return InkWell(
      onTap: () {
        selectedIndex = index;
        model.changeColor();
        log("${model.isSelected}");
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 1),
          color: index == selectedIndex
              ? model.isSelected
                  ? ColorConstants.blue
                  : ColorConstants.white
              : ColorConstants.white,
        ),
        child: Column(
          children: [
            Text(
              day,
              style: TextStyle(
                  color: index == selectedIndex
                      ? model.isSelected
                          ? ColorConstants.white
                          : ColorConstants.black
                      : ColorConstants.black,
                  fontSize: 18),
            ),
            Text(
              available,
              style: TextStyle(
                  color: index == selectedIndex
                      ? model.isSelected
                          ? ColorConstants.white
                          : ColorConstants.black
                      : ColorConstants.black),
            ),
          ],
        ),
      ),
    );
  }
}
