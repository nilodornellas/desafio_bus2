import 'package:desafio_bus2/core/database/local_storage.dart';
import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveLocalStorage implements LocalStorage {
  @override
  Future<void> init() async {
    final dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
  }

  Future<Box> _openBox(String boxName) async {
    if (!Hive.isBoxOpen(boxName)) {
      return await Hive.openBox(boxName);
    }
    return Hive.box(boxName);
  }

  @override
  Future<void> add({
    required RandomPerson randomPerson,
    required String boxName,
  }) async {
    final box = await _openBox(boxName);
    await box.put(randomPerson.login.id, randomPerson.toJson());
  }

  @override
  Future<List<RandomPerson>> getAll({required String boxName}) async {
    final box = await _openBox(boxName);
    return box.values.map((jsonStr) => RandomPerson.fromJson(jsonStr)).toList();
  }

  @override
  Future<void> remove({required String id, required String boxName}) async {
    final box = await _openBox(boxName);
    await box.delete(id);
  }

  @override
  Future<void> clear({required String boxName}) async {
    final box = await _openBox(boxName);
    await box.clear();
  }
}
