import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'firebase_file.dart';

class FirebaseApi {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls.asMap().entries.map((entry) {
      final index = entry.key;
      final url = entry.value;
      final ref = result.items[index];
      final name = ref.name;
      return FirebaseFile(ref: ref, name: name, url: url);
    }).toList();
  }
}