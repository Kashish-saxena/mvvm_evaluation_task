import 'package:mvvm_evaluation_task/core/view_model/base_model.dart';

class DoctorViewModel extends BaseModel {
  bool isSelected = false;

  void changeColor() {
    if (isSelected == true) {
      isSelected == true;
    } else {
      isSelected == false;
    }
    isSelected = !isSelected;
    updateUI();
  }
}
