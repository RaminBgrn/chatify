import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class MediaService {
  MediaService() {}

  Future<PlatformFile?> pickImageFromLibrary() async {
    FilePickerResult? mediaFile =
        await FilePicker.platform.pickFiles(type: FileType.image);
    if (mediaFile != null) {
      return mediaFile.files.first;
    }
    return null;
  }
}
