import 'package:get/get.dart';
import 'package:my_phone/Controllers/auth_controller.dart';

class AuthBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
