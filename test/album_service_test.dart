import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:itunes_teya_test/src/data/service/album_service_impl.dart';
import 'package:itunes_teya_test/src/utils/app_constants.dart';
import 'package:itunes_teya_test/src/utils/error_handler/app_exception.dart';
import 'album_service_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Dio>(), MockSpec<Interceptors>()])
void main() {
  late AlbumServiceImpl albumService;
  late MockDio mockDio;
  late MockInterceptors mockInterceptors;

  setUp(() {
    mockDio = MockDio();
    mockInterceptors = MockInterceptors();
    when(mockDio.interceptors).thenReturn(mockInterceptors);
    albumService = AlbumServiceImpl(dio: mockDio);
  });

  group('AlbumServiceImpl - fetchAllAlbums', () {
    const url = AppConstants.baseUrl;

    test(
      'should return a list of albums when the API call is successful',
      () async {
        final mockData = {
          "feed": {
            "entry": [
              {
                "id": {
                  "attributes": {"im:id": "1"},
                },
                "im:name": {"label": "Test Album"},
                "im:artist": {"label": "Test Artist"},
                "im:image": [
                  {"label": "http://test.com/image.jpg"},
                ],
                "im:releaseDate": {"label": "2024-01-01T00:00:00-07:00"},
                "category": {
                  "attributes": {"label": "Pop"},
                },
                "im:price": {
                  "attributes": {"amount": "9.99", "currency": "USD"},
                },
                "im:itemCount": {"label": "10"},
              },
            ],
          },
        };

        when(mockDio.get(url)).thenAnswer(
          (_) async => Response(
            data: jsonEncode(mockData),
            statusCode: 200,
            requestOptions: RequestOptions(path: url),
          ),
        );

        final result = await albumService.fetchAllAlbums();

        expect(result, isNotEmpty);
        expect(result.length, 1);
        expect(result.first.albumName, 'Test Album');
        expect(result.first.artistName, 'Test Artist');
      },
    );

    test('should throw AppException when API returns 404', () async {
      when(mockDio.get(url)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: url),
          response: Response(
            statusCode: 404,
            requestOptions: RequestOptions(path: url),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () async => await albumService.fetchAllAlbums(),
        throwsA(isA<AppException>().having((e) => e.code, 'code', 404)),
      );
    });

    test('should throw AppException when API returns 500', () async {
      when(mockDio.get(url)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: url),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: url),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () async => await albumService.fetchAllAlbums(),
        throwsA(isA<AppException>().having((e) => e.code, 'code', 500)),
      );
    });

    test('should throw AppException when response has no albums', () async {
      final emptyData = {
        "feed": {"entry": []},
      };

      when(mockDio.get(url)).thenAnswer(
        (_) async => Response(
          data: jsonEncode(emptyData),
          statusCode: 200,
          requestOptions: RequestOptions(path: url),
        ),
      );

      expect(
        () async => await albumService.fetchAllAlbums(),
        throwsA(isA<AppException>().having((e) => e.code, 'code', 404)),
      );
    });

    test('should throw AppException when network error occurs', () async {
      when(mockDio.get(url)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: url),
          type: DioExceptionType.connectionError,
        ),
      );

      expect(
        () async => await albumService.fetchAllAlbums(),
        throwsA(isA<AppException>()),
      );
    });
  });

  group('AlbumServiceImpl - fetchAlbumById', () {
    test('should return album when found by ID', () async {
      final mockData = {
        "feed": {
          "entry": [
            {
              "id": {
                "attributes": {"im:id": "123"},
              },
              "im:name": {"label": "Test Album"},
              "im:artist": {"label": "Test Artist"},
              "im:image": [
                {"label": "http://test.com/image.jpg"},
              ],
              "im:releaseDate": {"label": "2024-01-01T00:00:00-07:00"},
              "category": {
                "attributes": {"label": "Pop"},
              },
              "im:price": {
                "attributes": {"amount": "9.99", "currency": "USD"},
              },
              "im:itemCount": {"label": "10"},
            },
          ],
        },
      };

      when(mockDio.get(AppConstants.baseUrl)).thenAnswer(
        (_) async => Response(
          data: jsonEncode(mockData),
          statusCode: 200,
          requestOptions: RequestOptions(path: AppConstants.baseUrl),
        ),
      );

      final result = await albumService.fetchAlbumById('123');

      expect(result.id, '123');
      expect(result.albumName, 'Test Album');
    });

    test('should throw AppException when album with ID is not found', () async {
      final mockData = {
        "feed": {
          "entry": [
            {
              "id": {
                "attributes": {"im:id": "123"},
              },
              "im:name": {"label": "Test Album"},
              "im:artist": {"label": "Test Artist"},
              "im:image": [
                {"label": "http://test.com/image.jpg"},
              ],
              "im:releaseDate": {"label": "2024-01-01T00:00:00-07:00"},
              "category": {
                "attributes": {"label": "Pop"},
              },
              "im:price": {
                "attributes": {"amount": "9.99", "currency": "USD"},
              },
              "im:itemCount": {"label": "10"},
            },
          ],
        },
      };

      when(mockDio.get(AppConstants.baseUrl)).thenAnswer(
        (_) async => Response(
          data: jsonEncode(mockData),
          statusCode: 200,
          requestOptions: RequestOptions(path: AppConstants.baseUrl),
        ),
      );

      expect(
        () async => await albumService.fetchAlbumById('999'),
        throwsA(isA<AppException>().having((e) => e.code, 'code', 404)),
      );
    });

    test('should throw AppException when fetchAllAlbums fails', () async {
      when(mockDio.get(AppConstants.baseUrl)).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: AppConstants.baseUrl),
          response: Response(
            statusCode: 500,
            requestOptions: RequestOptions(path: AppConstants.baseUrl),
          ),
          type: DioExceptionType.badResponse,
        ),
      );

      expect(
        () async => await albumService.fetchAlbumById('123'),
        throwsA(isA<AppException>()),
      );
    });
  });
}
