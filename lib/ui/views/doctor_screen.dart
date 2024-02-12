import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/constants/color_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/image_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/string_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/text_styles.dart';
import 'package:mvvm_evaluation_task/core/models/availabilty_model.dart';
import 'package:mvvm_evaluation_task/core/models/users_reponse_model.dart';
import 'package:mvvm_evaluation_task/ui/widgets/navigation_button.dart';
import 'package:mvvm_evaluation_task/ui/widgets/common_button.dart';

class DoctorScreen extends StatelessWidget {
  const DoctorScreen({super.key, required this.arguments});
  final ResponseModel arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: buildBody(context),
    );
  }

  Widget buildBody(context) {
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
                        color: Colors.yellow,
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
                border: Border.all(width: 1, color: Colors.grey)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  height: 190,
                  width: 180,
                  child: arguments.avatar != null
                      ? Image.network(
                          "${arguments.avatar}",
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
                      arguments.firstName ?? "",
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
            margin: const EdgeInsets.symmetric(vertical: 20),
            height: 70,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: availability.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  Availability available = availability[index];
                  return buildAppointment(
                      index, available.day, available.availability);
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

  Widget buildAppointment(int index, String day, String available) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10),
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(width: 1),
        color: index == index / 2 ? ColorConstants.blue : ColorConstants.white,
      ),
      child: Column(
        children: [
          Text(
            day,
            style: TextStyle(
                color: index == index / 2
                    ? ColorConstants.white
                    : ColorConstants.black,
                fontSize: 18),
          ),
          Text(
            available,
            style: TextStyle(
                color: index == index / 2
                    ? ColorConstants.white
                    : ColorConstants.black),
          ),
        ],
      ),
    );
  }
}
