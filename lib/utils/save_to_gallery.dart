import 'dart:io';

import 'package:image_capture_app/utils/animated_snackbar.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

void saveImageToGallery(String filePath, context) async {
  PermissionStatus status = await Permission.storage.request();
  if (status.isGranted) {
    File imageFile = File(filePath);
    if (await imageFile.exists()) {
      Directory tempDir = await getTemporaryDirectory();
      String tempPath = tempDir.path;
      String newFilePath = '$tempPath/my_image.jpg';
      await imageFile.copy(newFilePath);

      final bytes = await File(newFilePath).readAsBytes();

      final result = await ImageGallerySaver.saveImage(bytes);

      if (result['isSuccess']) {
        showAnimatedSnackBar(context, "Image Saved To Gallery");
      } else {
        print(result);
      }
    } else {}
  } else {}
}
