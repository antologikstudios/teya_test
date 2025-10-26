import 'package:dio/dio.dart' hide DioErrorType;
import 'package:itunes_teya_test/src/data/models/album_model.dart';
import 'package:itunes_teya_test/src/utils/app_constants.dart';
import 'package:itunes_teya_test/src/utils/error_handler/app_exception.dart';
import 'package:itunes_teya_test/src/utils/error_handler/dio_error_type.dart';
import 'package:logger/logger.dart';
import 'album_service.dart';
import '../../utils/error_handler/dio_client_error_handler.dart';

final Logger _logger = Logger();

class AlbumServiceImpl implements AlbumService {
  final DioClientErrorHandler _httpClient;

  AlbumServiceImpl({Dio? dio}) : _httpClient = DioClientErrorHandler(dio: dio);

  @override
  Future<List<AlbumModel>> fetchAllAlbums() async {
    final jsonResponse = await _httpClient.getJson(AppConstants.baseUrl);

    final List<dynamic> result = jsonResponse['feed']?['entry'] ?? [];

    if (result.isEmpty) {
      _logger.w("No albums found.");
      throw AppException(
        message: DioErrorType.notFound.message,
        code: DioErrorType.notFound.code,
      );
    }
    return result
        .map((album) => AlbumModel.fromJson(album as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AlbumModel> fetchAlbumById(String id) async {
    final albums = await fetchAllAlbums();
    try {
      return albums.firstWhere((album) => album.id == id);
    } catch (e) {
      _logger.e("Album with ID $id not found");
      throw AppException(
        message: DioErrorType.notFound.message,
        code: DioErrorType.notFound.code,
      );
    }
  }
}
