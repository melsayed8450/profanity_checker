import 'package:flutter/material.dart';
import 'package:profanity_filter_app/profanity/app.dart';
import 'package:profanity_filter_app/profanity/injecter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();
  runApp(Profanity());
}
