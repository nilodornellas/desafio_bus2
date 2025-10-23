import 'package:desafio_bus2/core/api/http_client.dart';
import 'package:desafio_bus2/core/exceptions/http_request_exceptions.dart';
import 'package:desafio_bus2/core/database/local_storage.dart';
import 'package:desafio_bus2/core/exceptions/random_person_repository_exception.dart';
import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';

class RandomPersonRepositoryImpl implements RandomPersonRepository {
  final LocalStorage _storage;
  final HttpClient _httpClient;

  RandomPersonRepositoryImpl({
    required LocalStorage storage,
    required HttpClient httpClient,
  }) : _storage = storage,
       _httpClient = httpClient;

  @override
  Future<void> add(RandomPerson randomPerson) async {
    try {
      await _storage.add(randomPerson: randomPerson, boxName: 'random_people');
    } catch (e) {
      throw RandomPersonRepositoryException('Error on persist person: $e');
    }
  }

  @override
  Future<List<RandomPerson>> getAll() async {
    try {
      final response = await _storage.getAll(boxName: 'random_people');
      return response;
    } catch (e) {
      throw RandomPersonRepositoryException(
        'Error on list all persisted people: $e',
      );
    }
  }

  @override
  Future<RandomPerson> getOne() async {
    try {
      final response = await _httpClient.get('');
      final result = response['results'][0];
      final randomPerson = RandomPerson.fromMap(result);

      return randomPerson;
    } on HttpRequestException catch (e) {
      throw RandomPersonRepositoryException('Error on request: ${e.message}');
    } catch (e) {
      throw RandomPersonRepositoryException('Error on get one person: $e');
    }
  }

  @override
  Future<void> remove({required String id}) async {
    try {
      await _storage.remove(id: id, boxName: 'random_people');
    } catch (e) {
      throw RandomPersonRepositoryException('Error on remove person: $e');
    }
  }
}
