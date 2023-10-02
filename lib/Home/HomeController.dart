import 'dart:convert';

import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:todo_app_v1/Global/constant.dart';
import 'package:todo_app_v1/Home/HomeModels.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  List<User>? users;

  Future<void> getUsers() async {
    try {
      users = null;
      var response = await http.get(
        Uri.parse("${url}api/users?page=2"),
        headers: {},
      );

      users ??= [];
      if (response.statusCode == 200) {
        String body = utf8.decode(response.bodyBytes);
        json.decode(body)["data"].forEach((e) {
          users!.add(User.fromJson(e));
        });
      }

      update();
    } catch (e) {
      print(e);
      update();
    }
  }
}
