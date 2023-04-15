// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, duplicate_ignore

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:profanity_filter/profanity_filter.dart';
import 'package:http/http.dart' as http;

class HomeController extends GetxController {
  XFile? imageFile;
  ImagePicker imagePicker = ImagePicker();
  final filter = ProfanityFilter();
  final hasProfanity = false.obs;
  final isLoading = false.obs;

  TextEditingController textController = TextEditingController();
  Future<void> getPicture(BuildContext context) async {
    isLoading.value = true;
    if (await InternetConnectionChecker().hasConnection) {
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
    } else {
      isLoading.value = false;
      showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
          title: const Text('Error'),
          content: Text('Check internet connection then try again'),
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

  void checkWord() {
    hasProfanity.value = filter.hasProfanity(textController.text);
  }

  Future<void> checkImage(BuildContext context) async {
    var url = Uri.parse('https://api.sightengine.com/1.0/check.json');
    var request = http.MultipartRequest('POST', url);

    request.fields['models'] = 'nudity-2.0';
    request.fields['api_user'] = '1109846077';
    request.fields['api_secret'] = '4ExKYMNC5RL569Hs2JSk';

    var stream = http.ByteStream(imageFile!.openRead());
    var length = await imageFile!.length();
    var multipartFile =
        http.MultipartFile('media', stream, length, filename: 'image.jpg');
    request.files.add(multipartFile);

    var response = await request.send();
    var responseBody = await response.stream.bytesToString();

    var output = json.decode(responseBody);

    isLoading.value = false;
    // ignore: avoid_print
    print(output);
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Results'),
        content: SizedBox(
         height: 50,
          child: Column(
            children: [
              Text(
                output['nudity']['none'] < 0.05
                    ? 'The image contains nudity'
                    : 'The image doesn\'t contain nudity',
              ),
              Text(
                'Nudity percentage: ${(1 - output['nudity']['none']) * 100}%'
              ),
            ],
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
