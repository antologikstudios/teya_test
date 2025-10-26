import 'dart:convert';
import '../../../src/utils/date_formatter.dart';

class AlbumModel {
  final String id;
  final String albumName;
  final String artistName;
  final String coverImageUrl;
  final String? coverImageUrlLarge;
  final String releaseDate;
  final String category;
  final String? price;
  final String? currency;
  final int trackCount;
  final String? rights;

  const AlbumModel({
    required this.id,
    required this.albumName,
    required this.artistName,
    required this.coverImageUrl,
    this.coverImageUrlLarge,
    required this.releaseDate,
    required this.category,
    this.price,
    this.currency,
    required this.trackCount,
    this.rights,
  });

  factory AlbumModel.fromMap(Map<String, dynamic> map) {
    final List<dynamic> images = map['im:image'] ?? [];
    String coverImageUrl = '';
    String? coverImageUrlLarge;

    if (images.isNotEmpty) {
      // First Image (small/thumbnail)
      coverImageUrl = images.first['label'] ?? '';

      // Last Image (large/high resolution)
      if (images.length > 1) {
        coverImageUrlLarge = images.last['label'];
      }
    }

    final priceInfo = map['im:price'];
    String? price = priceInfo?['attributes']?['amount'];
    String? currency = priceInfo?['attributes']?['currency'];

    String releaseDate = '';
    try {
      final rawDate = map['im:releaseDate']?['label'] ?? '';
      if (rawDate.isNotEmpty) {
        releaseDate = formatUtcDateToYyyyMmDd(rawDate);
      }
    } catch (e) {
      releaseDate = map['im:releaseDate']?['label'] ?? '';
    }

    return AlbumModel(
      id: map['id']?['attributes']?['im:id'] ?? '',
      albumName: map['im:name']?['label'] ?? '',
      artistName: map['im:artist']?['label'] ?? '',
      coverImageUrl: coverImageUrl,
      coverImageUrlLarge: coverImageUrlLarge,
      releaseDate: releaseDate,
      category: map['category']?['attributes']?['label'] ?? '',
      price: price,
      currency: currency,
      trackCount: int.tryParse(map['im:itemCount']?['label'] ?? '0') ?? 0,
      rights: map['rights']?['label'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'album_name': albumName,
      'artist_name': artistName,
      'cover_image_url': coverImageUrl,
      'cover_image_url_large': coverImageUrlLarge,
      'release_date': releaseDate,
      'category': category,
      'price': price,
      'currency': currency,
      'track_count': trackCount,
      'rights': rights,
    };
  }

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel.fromMap(json);
  }

  Map<String, dynamic> toJson() {
    return toMap();
  }

  static List<AlbumModel> fromJsonList(String source) {
    final Map<String, dynamic> data = jsonDecode(source);
    final List<dynamic> entries = data['feed']?['entry'] ?? [];
    return entries
        .map((e) => AlbumModel.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
