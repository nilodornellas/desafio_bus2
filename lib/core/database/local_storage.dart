import 'package:desafio_bus2/data/models/random_person.dart';

abstract class LocalStorage {
  Future<void> init();
  Future<void> add({
    required RandomPerson randomPerson,
    required String boxName,
  });
  Future<void> remove({required String id, required String boxName});
  List<RandomPerson> getAll({required String boxName});
  Future<void> clear({required String boxName});
}
