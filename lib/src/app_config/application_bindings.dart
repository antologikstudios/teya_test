import 'package:get/get.dart';
import 'package:itunes_teya_test/src/data/repository/album_repository.dart';
import 'package:itunes_teya_test/src/data/repository/album_repository_impl.dart';
import 'package:itunes_teya_test/src/data/service/album_service.dart';
import 'package:itunes_teya_test/src/data/service/album_service_impl.dart';
import 'package:itunes_teya_test/src/modules/album/album_controller.dart';
import 'package:itunes_teya_test/src/modules/album_details/album_details_controller.dart';

// Application-wide bindings for dependency injection.
// This class is responsible for registering global dependencies that will
// be available throughout the application. It uses GetX Bindings
// that manage the lifecycle of dependencies efficiently.

class ApplicationBindings implements Bindings {
  @override
  // AlbumService and AlbumRepository: The implementations "AlbumServiceImpl" and "AlbumRepositoryImpl" are registered
  // using Get.lazyPut, ensuring they are only instantiated when needed. Get.find() handles locating the already injected dependencies.
  // Controllers: AlbumController and AlbumDetailsController are registered with fenix: true, meaning they will be recreated
  // if removed from memory, ensuring their availability when needed.
  void dependencies() {
    Get.lazyPut(
      () => AlbumController(albumRepository: Get.find()),
      fenix: true,
    );

    Get.lazyPut(
      () => AlbumDetailsController(albumRepository: Get.find()),
      fenix: true,
    );

    Get.lazyPut<AlbumRepository>(
      () => AlbumRepositoryImpl(albumService: Get.find()),
    );

    Get.lazyPut<AlbumService>(() => AlbumServiceImpl());
  }
}
