import 'dart:io';

import 'package:mixify/data/models/musique_model.dart';
import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/data/repository/musique_repository.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';
// ignore: depend_on_referenced_packages
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;

class MusiqueRepositoryImpl extends MusiqueRepository {
  @override
  Future<void> saveSelectedMusique({required SearchModel searchModel}) async {
    try {
      final yt = YoutubeExplode();
      final manifest =
          await yt.videos.streamsClient.getManifest(searchModel.urlSong);
      final video = await yt.videos.get(searchModel.urlSong);
      final duration = video.duration;
      final audio = manifest.audioOnly.withHighestBitrate();
      final response = await http.get(audio.url);
      final bytes = response.bodyBytes;
      final directory = await getApplicationDocumentsDirectory();
      final musiquePath =
          path.join(directory.path, '${searchModel.urlSong}.mp3');
      final file = File(musiquePath);
      await file.writeAsBytes(bytes);
      final imageResponse = await http.get(Uri.parse(searchModel.cover));
      final imageByte = imageResponse.bodyBytes;
      final imagePath =
          path.join(directory.path, '${searchModel.urlSong}.jpg');
      final imageFile = File(imagePath);
      await imageFile.writeAsBytes(imageByte);
      /* return MusiqueModel(
          path: musiquePath,
          artist: video.author,
          cover: searchModel.cover,
          title: video.title,
          duration: duration ?? const Duration(seconds: 0)); */
    } catch (e) {
      rethrow;
    }
  }

  static Future<String> getFilePath(String fileName) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath = path.join(directory.path, fileName);
    return filePath;
  }

  @override
  Future<MusiqueModel> streamMusiqueSelected(
      {required SearchModel searchModel}) async {
    try {
      final yt = YoutubeExplode();
      final manifest =
          await yt.videos.streamsClient.getManifest(searchModel.urlSong);
      final video = await yt.videos.get(searchModel.urlSong);
      final duration = video.duration;
      final audio = manifest.audioOnly.withHighestBitrate();
      return MusiqueModel(
          path: audio.url.toString(),
          artist: video.author,
          cover: searchModel.cover,
          title: video.title,
          duration: duration ?? const Duration(seconds: 0));
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> downloadMusic({required SearchModel searchModel}) async {}
}
