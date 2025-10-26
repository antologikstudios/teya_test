import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'album_controller.dart';

class AlbumPage extends GetView<AlbumController> {
  const AlbumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Itunes Album List'),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
              if (controller.errorMessage.isNotEmpty) {
                return Center(child: Text(controller.errorMessage.value));
              }
              return ListView.builder(
                itemCount: controller.albumList.length,
                itemBuilder: (context, index) {
                  final album = controller.albumList[index];
                  return ListTile(
                    leading: Image.network(
                      album.coverImageUrl,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(Icons.image_not_supported, size: 50);
                      },
                    ),
                    title: Text(album.albumName),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text('Artist: ${album.artistName}')],
                    ),
                    onTap: () => controller.navigateToDetails(album.id),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
