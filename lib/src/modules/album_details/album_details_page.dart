import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:itunes_teya_test/src/app_config/app_text_theme.dart';
import 'package:itunes_teya_test/src/modules/album_details/album_details_controller.dart';
import 'package:itunes_teya_test/src/modules/album_details/widgets/album_details_text_widget.dart';

class AlbumDetailsPage extends GetView<AlbumDetailsController> {
  const AlbumDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() {
          final albumDetails = controller.albumDetails.value;
          return Text(
            albumDetails?.albumName ?? 'Loading...',
            style: AppTextTheme.appBarTitle,
          );
        }),
      ),
      body: Obx(() {
        final albumDetails = controller.albumDetails.value;
        if (albumDetails == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Obx(() {
                  final imageUrl =
                      controller.albumDetails.value?.coverImageUrlLarge ?? '';
                  return Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.image_not_supported,
                            size: 200,
                          );
                        },
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        },
                      ),
                    ],
                  );
                }),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Obx(() {
                    final album = controller.albumDetails.value;
                    if (album == null) return const SizedBox.shrink();

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        AlbumDetailsText(
                          title: 'Artist:',
                          value: album.artistName,
                        ),
                        AlbumDetailsText(
                          title: 'Release Date:',
                          value: album.releaseDate,
                        ),
                        AlbumDetailsText(
                          title: 'Category:',
                          value: album.category,
                        ),
                        AlbumDetailsText(
                          title: 'Number of Tracks:',
                          value: '${album.trackCount}',
                        ),
                        if (album.price != null && album.currency != null)
                          AlbumDetailsText(
                            title: 'Price:',
                            value: '${album.price} ${album.currency}',
                          ),
                        if (album.rights != null)
                          AlbumDetailsText(
                            title: 'Rights:',
                            value: album.rights!,
                          ),
                      ],
                    );
                  }),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
