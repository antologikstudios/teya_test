import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:itunes_teya_test/src/app_config/application_bindings.dart';
import 'package:itunes_teya_test/src/routes/routes_pages/album_details_route.dart';
import 'package:itunes_teya_test/src/routes/routes_pages/album_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/album', // The initial route of the application
      initialBinding: ApplicationBindings(), // Registers global dependencies
      getPages: [
        ...AlbumRoute().routers,
        ...AlbumDetailsRoute().routers,
      ], // Configures the routes for the Album module.
    );
  }
}
