import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app_v1/Global/GlobalModels.dart';
import 'package:todo_app_v1/Global/constant.dart';

class LoginController extends GetxController {
  bool showPassword = false;

  void changeShowPasswordStatus() {
    showPassword = !showPassword;
    update();
  }

  Future<RequestResponse> login({required String email, required String password}) async {
    try {
      // email = "eve.holt@reqres.in";
      // password = "cityslicka";
      var response = await http.post(
        Uri.parse("${url}api/login"),
        headers: {},
        body: {
          "email": email,
          "password": password,
        },
      );

      return RequestResponse(response.statusCode == 200 ? true : false, response.body);
    } catch (e) {
      print(e);
      return RequestResponse(false, e.toString());
    }
  }
}
