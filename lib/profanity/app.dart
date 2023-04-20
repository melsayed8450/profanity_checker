import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:profanity_filter_app/profanity/presentation/routes/app_pages.dart';
import 'package:profanity_filter_app/profanity/presentation/routes/app_routes.dart';


class Profanity extends StatelessWidget {
  const Profanity({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      smartManagement: SmartManagement.keepFactory,
      getPages: AppRoutes.routes,
      initialRoute: AppPages.home,
    );
  }
}
