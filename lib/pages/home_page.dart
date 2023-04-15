import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../manager/home_controller.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final controller = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final heigth = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: heigth * 0.1),
            child: const Text(
              'Profanity Filter',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 45),
            ),
          ),
          Obx(() {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.1),
              child: TextField(
                controller: controller.textController,
                decoration: InputDecoration(
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    labelText: 'Enter text you want to check Profanity',
                    errorText:
                        controller.hasProfanity.value ? 'Bad word' : null,
                    border: const OutlineInputBorder(
                        borderSide: BorderSide(
                      color: Color.fromARGB(255, 224, 221, 221),
                    ))),
              ),
            );
          }),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: TextButton(
              onPressed: () {
                controller.checkWord();
              },
              child: Container(
                width: width * 0.5,
                height: heigth * 0.06,
                decoration: const BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
                child: const Center(
                  child: Text('CHECK TEXT',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 24,
                      )),
                ),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              controller.getPicture(context);
            },
            child: SizedBox(
              height: 50,
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Text(
                    'Check an image',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                ],
              ),
            ),
          ),
          Obx(() {
            return Visibility(
                visible: controller.isLoading.value,
                child: const CircularProgressIndicator());
          }),
        ],
      ),
    );
  }
}
