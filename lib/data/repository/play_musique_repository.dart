abstract class PlayMusiqueRepository {
  Future<void> playStreamMusique({required String streamPath});

  Future<void> stopStreamMusique();

  Future<void> pauseStreamMusique();

  Future<void> seekStreaMusique({required Duration position});

  Future<void> stopWhenChangeListenPage({required String id});
}
