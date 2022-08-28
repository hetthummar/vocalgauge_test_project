import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:stacked/stacked.dart';

class CustomBaseViewModel extends BaseViewModel {

  showProgressBar({String title = "Please wait..."}) {
    EasyLoading.show(status: title);
  }

  stopProgressBar() {
    EasyLoading.dismiss();
  }
}
