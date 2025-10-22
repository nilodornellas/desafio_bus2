import 'package:desafio_bus2/data/models/random_person.dart';

abstract class RandomPersonRepository {
  Future<void> add(RandomPerson randomPerson);
  Future<RandomPerson> getOne();
  List<RandomPerson> getAll();
  Future<void> remove({required String id});
}
