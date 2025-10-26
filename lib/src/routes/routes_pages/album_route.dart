import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:itunes_teya_test/src/app_config/application_bindings.dart';
import 'package:itunes_teya_test/src/modules/album/album_page.dart';
import 'package:itunes_teya_test/src/routes/routes.dart';

class AlbumRoute implements Routes {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/album',
      page: () => const AlbumPage(),
      binding: ApplicationBindings(),
    ),
  ];
}
