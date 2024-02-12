import 'package:flutter/material.dart';
import 'package:mvvm_evaluation_task/core/constants/color_constants.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key, required this.onTap});
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: const Icon(
          Icons.arrow_back,
          color: ColorConstants.black,
          size: 30,
          weight: 50,
        ),
      ),
    );
  }
}
