import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:todo_app_v1/Global/SecureStorage.dart';
import 'package:todo_app_v1/Global/constant.dart';
import 'package:todo_app_v1/Home/HomeController.dart';
import 'package:todo_app_v1/Login/Login.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final controller = Get.put(HomeController());

  @override
  void initState() {
    controller.getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    EdgeInsets padding = MediaQuery.of(context).padding;
    return Scaffold(
      body: Container(
          width: size.width,
          height: size.height,
          color: kBackgroundColor,
          child: GetBuilder<HomeController>(builder: (_) {
            return controller.users == null
                ? const Center(
                    child: CircularProgressIndicator(
                      color: kPrimaryColor,
                    ),
                  )
                : controller.users!.isEmpty
                    ? Center(
                        child: Text(
                          'Users not found',
                          style: k14w400AxiBlack(),
                        ),
                      )
                    : SingleChildScrollView(
                        physics: kPhysic,
                        child: Column(
                          children: [
                            SizedBox(height: padding.top),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 5.0),
                              child: Column(
                                children: [
                                  Wrap(
                                    spacing: 10,
                                    runSpacing: 10,
                                    children: [
                                      for (var i = 0; i < controller.users!.length; i++)
                                        Container(
                                          width: (size.width - 20) / 2,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${controller.users![i].firstName} ${controller.users![i].lastName}",
                                                style: k14w400AxiBlack(),
                                              ),
                                              Text(
                                                "${controller.users![i].email}",
                                                style: k10w400AxiBlack(),
                                              ),
                                              const SizedBox(height: 5),
                                              controller.users![i].avatar != null
                                                  ? Image.network(
                                                      controller.users![i].avatar!,
                                                      fit: BoxFit.cover,
                                                      width: (size.width - 30) / 2,
                                                      height: (size.width - 30) / 2,
                                                    )
                                                  : Container(
                                                      width: (size.width - 30) / 2,
                                                      height: (size.width - 30) / 2,
                                                      color: Colors.white,
                                                    )
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                  InkWell(
                                    onTap: () {
                                      SecureStorage.setAlreadyLogin('false').then((value) => Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                            builder: (context) => const Login(),
                                          ),
                                          (route) => false));
                                    },
                                    child: Container(
                                      width: size.width,
                                      padding: const EdgeInsets.all(15),
                                      margin: const EdgeInsets.symmetric(horizontal: 15),
                                      decoration: const BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(15),
                                        ),
                                        boxShadow: [BoxShadow(color: Colors.black12, spreadRadius: 2, blurRadius: 3, offset: Offset.zero)],
                                      ),
                                      child: Center(
                                        child: Text(
                                          'Logout',
                                          style: k16w400MontBlack(color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.02),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
          })),
    );
  }
}
