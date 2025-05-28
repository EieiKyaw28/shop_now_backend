import 'dart:developer';
import 'dart:io';
import 'package:supabase_flutter/supabase_flutter.dart';

class CommonStoreImage {
  Future<String> uploadAvatar({
    required String bucketName,
    required File avatarFile}) async {
    try {
      final supabase = Supabase.instance.client;
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();

      final String filePath = await supabase.storage
          .from('images')
          .upload(
            '$bucketName/$fileName.png',
            avatarFile,
            fileOptions: const FileOptions(cacheControl: '3600', upsert: true),
          );
      print('Uploaded to: $filePath');
      return filePath;
    } on StorageException catch (error, st) {
      print('StorageException: ${error.message} ${st}');
      rethrow;
    } catch (err) {
      print('Unexpected error: $err');
      rethrow;
    }
  }

  lookupMimeType(String path) {}
}
