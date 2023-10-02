import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:get/instance_manager.dart';
import 'package:todo_app_v1/BottomNavigator/BottomNavigatorBar.dart';
import 'package:todo_app_v1/Global/SecureStorage.dart';
import 'package:todo_app_v1/Global/constant.dart';
import 'package:todo_app_v1/Login/LoginController.dart';
import 'package:todo_app_v1/Types/BannerType.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final controller = Get.put(LoginController());

  final TextEditingController email = TextEditingController(text: "");
  final TextEditingController password = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
          body: Container(
            width: size.width,
            height: size.height,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                SizedBox(height: padding.top),
                Flexible(
                  flex: 2,
                  child: Center(
                    child: Image.asset(
                      'assets/images/reqres.jpeg',
                      width: size.width * 0.5,
                      height: size.width * 0.5,
                    ),
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: GetBuilder<LoginController>(builder: (_) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextFormField(
                          textInputAction: TextInputAction.next,
                          style: k14w400AxiBlack(),
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: "E-Mail",
                            labelStyle: k16w400MontBlack(),
                          ),
                          controller: email,
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          style: k14w400AxiBlack(),
                          obscureText: controller.showPassword,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                              icon: Icon(
                                (controller.showPassword == true) ? Icons.visibility_off_sharp : Icons.visibility_sharp,
                                color: Colors.black,
                              ),
                              onPressed: () => controller.changeShowPasswordStatus(),
                            ),
                            contentPadding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            labelText: "Password",
                            labelStyle: k16w400MontBlack(),
                          ),
                          controller: password,
                        ),
                        SizedBox(
                          height: size.height * 0.05,
                        ),
                        Material(
                          elevation: 5.0,
                          borderRadius: BorderRadius.circular(8.0),
                          color: kPrimaryColor,
                          child: MaterialButton(
                            minWidth: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                            onPressed: () async {
                              if (email.text == "" || password.text == "") {
                                kShowBanner(BannerType.ERROR, "Email or password fields cannot be left blank", context);
                                return;
                              }
                              await controller.login(email: email.text, password: password.text).then((requestResponse) {
                                if (requestResponse.result == false) {
                                  kShowBanner(BannerType.ERROR, requestResponse.message, context);
                                } else {
                                  SecureStorage.setAlreadyLogin('true').then((value) {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => BottomNavigator(),
                                        ));
                                  });
                                }
                              });
                            },
                            child: Text(
                              "Login",
                              textAlign: TextAlign.center,
                              style: k17w600MontWhite(),
                            ),
                          ),
                        ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
