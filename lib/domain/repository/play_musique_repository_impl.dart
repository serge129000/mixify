//import 'package:audioplayers/audioplayers.dart';
import 'package:mixify/data/repository/play_musique_repository.dart';
import 'package:just_audio/just_audio.dart';

class PlayMusiqueRepositoryImpl implements PlayMusiqueRepository {
  final AudioPlayer audioPlayer;
  PlayMusiqueRepositoryImpl({required this.audioPlayer});
  @override
  Future<void> playStreamMusique({required String streamPath}) async {
    await audioPlayer.setUrl(streamPath);
    await audioPlayer.play();
  }

  @override
  Future<void> stopStreamMusique() async {
    await audioPlayer.stop();
  }

  @override
  Future<void> pauseStreamMusique() async {
    await audioPlayer.pause();
  }

  @override
  Future<void> seekStreaMusique({required Duration position}) async {
    await audioPlayer.seek(position);
  }

  @override
  Future<void> stopWhenChangeListenPage({required String id}) async {
    /* print(audioPlayer.playerId != id);
    if (audioPlayer.playerId != id) {
      await audioPlayer.stop();
    } */
  }
}
