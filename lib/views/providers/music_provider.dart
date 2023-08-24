import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mixify/data/models/musique_model.dart';
import 'package:mixify/data/models/search_model.dart';
import 'package:mixify/data/repository/play_musique_repository.dart';
import 'package:mixify/domain/repository/musique_repository_impl.dart';
import 'package:mixify/utils/utils.dart';
import 'package:palette_generator/palette_generator.dart';

import '../../domain/repository/play_musique_repository_impl.dart';

class MusicProvider with ChangeNotifier {
  Status _status = Status.initial;
  Status get status => _status;
  MusiqueModel? _musiqueModel;
  MusiqueModel? get musiqueModel => _musiqueModel;
  Color? _primaryColor;
  Color get primaryColor => _primaryColor ?? Colors.lightBlue;
  Color? _secondColor;
  Color get secondColor => _secondColor ?? Colors.lightBlue;
  List<SearchModel> _currentPlaylist = [];
  List<SearchModel> get currentPlaylist => _currentPlaylist;
  int _index = 0;
  int get index => _index;
  Status _playingMusicStatus = Status.initial;
  Status get playingMusicStatus => _playingMusicStatus;
  Status _stopMusicStatus = Status.initial;
  Status get stopMusicStatus => _stopMusicStatus;
  Status _seekMusicStatus = Status.initial;
  Status get seekMusicStatus => _seekMusicStatus;
  Future<void> streamMusique({required SearchModel searchModel}) async {
    _status = Status.loading;
    notifyListeners();
    try {
      _musiqueModel = await MusiqueRepositoryImpl()
          .streamMusiqueSelected(searchModel: searchModel);
      _status = Status.loaded;
      notifyListeners();
    } catch (e) {
      _status = Status.error;
      notifyListeners();
    }
  }

  Future<void> getCoverColor({required String cover}) async {
    try {
      final PaletteGenerator paletteGenerator =
          await PaletteGenerator.fromImageProvider(NetworkImage(cover));
      _primaryColor = paletteGenerator.dominantColor!.color;
      _secondColor = paletteGenerator.paletteColors.last.color;
      notifyListeners();
    } catch (e) {
      _primaryColor = null;
      _secondColor = null;
      notifyListeners();
    }
  }

  void setNewPlayList({required List<SearchModel> musics}) {
    _currentPlaylist = musics;
    notifyListeners();
  }

  void setNewIndex({required int newindex}) {
    _index = newindex;
    notifyListeners();
  }

  void playStreamMusic(
      {required AudioPlayer audioPlayer, required String streamPath}) {
    _playingMusicStatus = Status.loading;
    notifyListeners();
    try {
      PlayMusiqueRepositoryImpl(audioPlayer: audioPlayer)
          .playStreamMusique(streamPath: streamPath);
      _playingMusicStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      _playingMusicStatus = Status.error;
      notifyListeners();
    }
  }

  void pauseMusic({required AudioPlayer audioPlayer}) {
    _stopMusicStatus = Status.loading;
    notifyListeners();
    try {
      PlayMusiqueRepositoryImpl(audioPlayer: audioPlayer).pauseStreamMusique();
      _stopMusicStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      _stopMusicStatus = Status.error;
      notifyListeners();
    }
  }

  void seekMusique(
      {required AudioPlayer audioPlayer, required Duration duration}) {
    _seekMusicStatus = Status.loading;
    notifyListeners();
    try {
      PlayMusiqueRepositoryImpl(audioPlayer: audioPlayer).seekStreaMusique(position: duration);
      _seekMusicStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      _seekMusicStatus = Status.error;
      notifyListeners();
    }
  }

  void stopMusique({required AudioPlayer audioPlayer}) {
    _stopMusicStatus = Status.loading;
    notifyListeners();
    try {
      PlayMusiqueRepositoryImpl(audioPlayer: audioPlayer).stopStreamMusique();
      _stopMusicStatus = Status.loaded;
      notifyListeners();
    } catch (e) {
      _stopMusicStatus = Status.error;
      notifyListeners();
    }
  }
}
