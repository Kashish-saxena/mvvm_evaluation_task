import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:mvvm_evaluation_task/core/constants/color_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/image_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/string_constants.dart';
import 'package:mvvm_evaluation_task/core/constants/text_styles.dart';
import 'package:mvvm_evaluation_task/core/enums/view_state.dart';
import 'package:mvvm_evaluation_task/core/models/categories_model.dart';
import 'package:mvvm_evaluation_task/core/models/users_reponse_model.dart';
import 'package:mvvm_evaluation_task/core/routing/routes.dart';
import 'package:mvvm_evaluation_task/core/view_model/home_view_model.dart';
import 'package:mvvm_evaluation_task/ui/views/base_view.dart';
import 'package:mvvm_evaluation_task/ui/widgets/navigation_button.dart';

// ignore: must_be_immutable
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  HomeViewModel? model;

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();
    int currentPage = 1;
    bool isLoading = true;

    return BaseView<HomeViewModel>(
      onModelReady: (model) {
        scrollController.addListener(() {
          if (scrollController.offset ==
              scrollController.position.maxScrollExtent) {
            currentPage++;
            isLoading = false;
            model.getData(context, currentPage);
          }
        });
        this.model = model;
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          model.getData(context, currentPage);
        });
      },
      builder: (context, model, child) {
        return Scaffold(
          body: buildBody(context, scrollController, model, isLoading),
        );
      },
    );
  }

  Widget buildBody(BuildContext context, ScrollController scrollController,
      HomeViewModel model, isLoading) {
    return SingleChildScrollView(
      controller: scrollController,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          buildAppBar(context),
          buildTitle(
            StringConstants.category,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                StringConstants.seeMore,
                style: TextStyles.textStyleFont20Weight400
                    .copyWith(fontSize: 14, color: Colors.grey),
              ),
            ),
          ),
          buildCategory(),
          buildTitle(
            StringConstants.popularDoctor,
          ),
          model.state == ViewState.busy
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : buildList(model, isLoading),
        ],
      ),
    );
  }

  Widget buildList(HomeViewModel model, bool isLoading) {
    return ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: model.doctorData.length + 1,
        itemBuilder: (context, index) {
          if (index < model.doctorData.length) {
            ResponseModel? user = model.doctorData[index];
            return InkWell(
              onTap: () {
                Navigator.pushNamed(context, Routes.doctorScreen,
                    arguments: user);
              },
              child: Container(
                clipBehavior: Clip.antiAlias,
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.6, 0.9],
                    colors: [ColorConstants.background, ColorConstants.white],
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        user.avatar != null
                            ? Image.network(
                                "${user.avatar}",
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              )
                            : Image.asset(ImageConstants.profile),
                        const Positioned(
                          right: 10,
                          top: 2,
                          child: Row(children: [
                            Icon(
                              Icons.star,
                              color: ColorConstants.amber,
                              size: 20,
                            ),
                            Text(
                              StringConstants.rating,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ]),
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.firstName ?? "",
                          style: const TextStyle(fontSize: 20),
                        ),
                        const Text(
                          StringConstants.dentist,
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            );
          } else {
            return Container(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : const Center(child: Text("No More Data to Load")));
          }
        });
  }

  Widget buildTitle(String title) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Text(
        title,
        style: TextStyles.textStyleFont20Weight400.copyWith(fontSize: 18),
      ),
    );
  }

  Widget buildCategory() {
    return SizedBox(
      height: 120,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: category.length,
          itemBuilder: (context, index) {
            Categories categories = category[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Image.asset(categories.image),
            );
          }),
    );
  }

  Widget buildAppBar(context) {
    return SizedBox(
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
                onTap: () => SystemNavigator.pop(),
              ),
              title: const Text(
                StringConstants.findDoctor,
                style: TextStyles.textStyleFont20Weight400,
              ),
              trailing: Container(
                margin: const EdgeInsets.symmetric(horizontal: 10),
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
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, top: 120),
            decoration: BoxDecoration(
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 4),
                  blurRadius: 5,
                ),
              ],
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              leading: const Icon(Icons.search_outlined),
              title: const Text(StringConstants.search),
              trailing: Image.asset(ImageConstants.vector),
            ),
          ),
        ],
      ),
    );
  }
}
