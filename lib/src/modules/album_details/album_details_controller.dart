import 'package:get/get.dart';
import 'package:itunes_teya_test/src/data/models/album_model.dart';
import 'package:itunes_teya_test/src/data/repository/album_repository.dart';
import 'package:itunes_teya_test/src/utils/error_handler/app_exception.dart';

class AlbumDetailsController extends GetxController {
  final AlbumRepository _albumRepository;
  final Rx<AlbumModel?> albumDetails = Rx<AlbumModel?>(null);
  final isLoading = true.obs;
  final errorMessage = ''.obs;

  AlbumDetailsController({required AlbumRepository albumRepository})
    : _albumRepository = albumRepository;

  @override
  void onInit() {
    super.onInit();
    //Get the argument passed from the previous screen
    // and load the album details.
    final String? albumIdFromArgs = Get.arguments['id'];
    if (albumIdFromArgs != null) {
      loadAlbumDetails(albumIdFromArgs);
    }
  }

  // Load specific album details by ID.
  Future<void> loadAlbumDetails(String id) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final album = await _albumRepository.fetchAlbumById(id);
      albumDetails.value = album;
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
        : 'Unexpected error loading album details';
    Get.snackbar('Error', errorMessage.value);
  }
}
