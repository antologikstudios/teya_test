import 'package:itunes_teya_test/src/data/models/album_model.dart';

abstract interface class AlbumRepository {
  Future<List<AlbumModel>> fetchAllAlbums();
  Future<AlbumModel> fetchAlbumById(String id);
}
