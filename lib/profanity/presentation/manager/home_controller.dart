// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, duplicate_ignore


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:profanity_filter_app/profanity/domain/entities/response_entity.dart';
import 'package:profanity_filter_app/profanity/domain/use_cases/response_use_case.dart';


class HomeController extends GetxController {
  XFile? imageFile;
  ImagePicker imagePicker = ImagePicker();
  final filter = ProfanityFilter();
  final hasProfanity = false.obs;
  final isLoading = false.obs;
  late Future<ResponseEntity> responseEntity;
  final ResponseUseCase responseUseCase;
  HomeController(this.responseUseCase);

  TextEditingController textController = TextEditingController();
  Future<void> getPicture(BuildContext context) async {
    isLoading.value = true;

    try {
      final pickedFile =
          await imagePicker.pickImage(source: ImageSource.gallery);
      imageFile = pickedFile;
    } catch (e) {
      isLoading.value = false;

      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred during image picking'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
    if (imageFile != null) {
      checkImage(context);
    } else {
      isLoading.value = false;
    }
  }

  void checkWord() {
    hasProfanity.value = filter.hasProfanity(textController.text);
  }

  Future<void> checkImage(BuildContext context) async {
    final output = await responseUseCase.call(imageFile);

    isLoading.value = false;
    // ignore: avoid_print
    print(output);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Results'),
        content: SizedBox(
          height: 70,
          child: Center(
            child: Column(
              children: [
                Text(
                  output.none < 0.05
                      ? 'The image contains nudity'
                      : 'The image doesn\'t contain nudity',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  'Nudity percentage: ${((1 - output.none) * 100).floor()}%',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
