import 'package:desafio_bus2/core/api/http_client.dart';
import 'package:desafio_bus2/core/api/http_request_exceptions.dart';
import 'package:desafio_bus2/core/database/local_storage.dart';
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
  Future<void> add(RandomPerson randomPerson) async =>
      await _storage.add(randomPerson: randomPerson, boxName: 'random_people');

  @override
  Future<List<RandomPerson>> getAll() async =>
      await _storage.getAll(boxName: 'random_people');

  @override
  Future<RandomPerson> getOne() async {
    try {
      final response = await _httpClient.get('');
      final result = response['results'][0];
      final randomPerson = RandomPerson.fromMap(result);

      return randomPerson;
    } on HttpRequestException catch (e) {
      throw Exception('Erro ao buscar pessoa na API: ${e.message}');
    } catch (e) {
      throw Exception('Erro inesperado: $e');
    }
  }

  @override
  Future<void> remove({required String id}) async =>
      await _storage.remove(id: id, boxName: 'random_people');
}
