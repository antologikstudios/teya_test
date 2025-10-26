import 'package:itunes_teya_test/src/data/models/album_model.dart';
import 'package:itunes_teya_test/src/data/service/album_service.dart';

import 'album_repository.dart';

// Implementation of the AlbumRepository interface.
// This class acts as an intermediary between the service layer and the
// rest of the application, delegating API calls to the AlbumService
// and handling any additional business logic if needed.

class AlbumRepositoryImpl implements AlbumRepository {
  final AlbumService _albumService;

  // Constructor that injects the required AlbumService dependency.
  // This ensures better testability and adherence to dependency inversion principles.

  AlbumRepositoryImpl({required AlbumService albumService})
    : _albumService = albumService;

  @override
  Future<List<AlbumModel>> fetchAllAlbums() async {
    final albums = await _albumService.fetchAllAlbums();
    return albums.map((album) {
      return AlbumModel(
        id: album.id,
        albumName: album.albumName,
        artistName: album.artistName,
        coverImageUrl: album.coverImageUrl,
        coverImageUrlLarge: album.coverImageUrlLarge,
        releaseDate: album.releaseDate,
        category: album.category,
        price: album.price,
        currency: album.currency,
        trackCount: album.trackCount,
        rights: album.rights,
      );
    }).toList();
  }

  @override
  Future<AlbumModel> fetchAlbumById(String id) async {
    final album = await _albumService.fetchAlbumById(id);
    return AlbumModel(
      id: album.id,
      albumName: album.albumName,
      artistName: album.artistName,
      coverImageUrl: album.coverImageUrl,
      coverImageUrlLarge: album.coverImageUrlLarge,
      releaseDate: album.releaseDate,
      category: album.category,
      price: album.price,
      currency: album.currency,
      trackCount: album.trackCount,
      rights: album.rights,
    );
  }
}
