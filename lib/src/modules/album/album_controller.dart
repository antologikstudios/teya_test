import 'package:get/get.dart';
import 'package:itunes_teya_test/src/data/models/album_model.dart';
import 'package:itunes_teya_test/src/data/repository/album_repository.dart';
import 'package:itunes_teya_test/src/utils/error_handler/app_exception.dart';

class AlbumController extends GetxController {
  // Observable list of all albums fetched from the API.
  final albumList = <AlbumModel>[].obs;
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  // The AlbumRepository is injected into the controller via the constructor.
  // This allows for better testability and adherence to dependency inversion principles.
  final AlbumRepository _albumRepository;

  AlbumController({required AlbumRepository albumRepository})
    : _albumRepository = albumRepository;

  @override
  void onInit() {
    super.onInit();
    loadAlbums();
  }

  // Centralize the  logic for loading albums.
  Future<void> loadAlbums() async {
    await _executeWithLoading(() async {
      albumList.value = await _albumRepository.fetchAllAlbums();
      // Initialize with all albums
    });
  }

  // Generic method to handle loading states and errors.
  Future<void> _executeWithLoading(Future<void> Function() action) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      await action();
    } catch (e) {
      _handleError(e);
    } finally {
      isLoading.value = false;
    }
  }

  // Handle errors that occur during the loading process.
  void _handleError(dynamic error) {
    errorMessage.value = error is AppException
        ? error.message
        : 'Unexpected error loading albums';
  }

  // Navigates to the details page of a specific album and passing the albumID
  // by argument instead via contructor (GetX Feature).
  void navigateToDetails(String id) {
    Get.toNamed('/albumDetails', arguments: {'id': id});
  }
}
