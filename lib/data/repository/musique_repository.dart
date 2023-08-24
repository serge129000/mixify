import 'package:mixify/data/models/musique_model.dart';
import 'package:mixify/data/models/search_model.dart';

abstract class MusiqueRepository {
  Future<void> saveSelectedMusique({required SearchModel searchModel});
  Future<MusiqueModel> streamMusiqueSelected(
      {required SearchModel searchModel});
  Future<void> downloadMusic({required SearchModel searchModel});
}
