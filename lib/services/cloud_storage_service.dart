import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

const String USER_COLLECTION = 'Users';

class CloudStorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  CloudStorageService();

  Future<String?> saveUserImageToStorage(
      String uid, PlatformFile profileImage) async {
    try {
      Reference ref = _storage
          .ref()
          .child('images/users/$uid/profile.${profileImage.extension}');
      UploadTask task = ref.putFile(File(profileImage.path!));
      return await task.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      log('Something went wrong while update image');
    }
    return null;
  }

  Future<String?> saveChatImageToStorage(
      String chatId, String userId, PlatformFile file) async {
    try {
      Reference ref = _storage.ref().child(
          'images/chats/$chatId/${userId}_${Timestamp.now().millisecondsSinceEpoch}.${file.extension}');
      UploadTask task = ref.putFile(File(file.path!));
      return await task.then((result) => result.ref.getDownloadURL());
    } catch (e) {
      log('Something went wrong while update image');
    }
    return null;
  }
}
