import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class MyControler extends GetxController {
  RxString city = ''.obs;
  RxDouble degree = 0.0.obs;
  RxString weatherCondition = ''.obs;
  RxString icon = ''.obs;

  RxDouble lat = 0.0.obs;
  RxDouble long = 0.0.obs;
}
