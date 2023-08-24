//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider with ChangeNotifier {
  AudioPlayer? _audioPlayer;
  AudioPlayer? get audioPlayer => _audioPlayer;
  bool? _isPlaying;
  bool? _isPaused;
  bool? get isPlaying => _isPlaying;
  bool? get isPauses => _isPaused;
  Duration? _duration;
  Duration? get duration => _duration;
  Duration? _position;
  Duration? get position => _position;
  String? _currentMusicCode;
  String? get currentMusicCode => _currentMusicCode;
  void initAudioPlayer(/* {required String id} */) {
    _audioPlayer = AudioPlayer(/* userAgent: id */);
    notifyListeners();
  }

  void setPlayingState({required bool isPlaying}) {
    _isPlaying = isPlaying;
    notifyListeners();
  }

  void setPausedState({required bool? isPaused}) {
    _isPaused = isPaused;
    notifyListeners();
  }

  void setAudioPlayerId({required String newId}) {
    _currentMusicCode = newId;
    notifyListeners();
  }

  void setNewDuration({required Duration newDuration}) {
    _duration = newDuration;
    notifyListeners();
  }

  void setNewPosition({required Duration newPosition}) {
    _position = newPosition;
    notifyListeners();
  }
}
