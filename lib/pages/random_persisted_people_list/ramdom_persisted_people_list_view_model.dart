import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:flutter/material.dart';

class RamdomPersistedPeopleListViewModel extends ChangeNotifier {
  final RandomPersonRepository _repository;

  RamdomPersistedPeopleListViewModel({
    required RandomPersonRepository repository,
  }) : _repository = repository;

  bool _initialLoading = true;
  bool get isInitialLoading => _initialLoading;

  List<RandomPerson> _persistedPeople = [];
  List<RandomPerson> get persistedPeople => _persistedPeople;

  Future<void> init() async {
    _initialLoading = true;
    notifyListeners();
    try {
      loadPersistedPeople();
    } catch (e) {
      // Handle error appropriately, e.g., log or show a message
    } finally {
      _initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPersistedPeople() async {
    _persistedPeople = await _repository.getAll();
    notifyListeners();
  }

  Future<void> removePerson(String personId) async {
    try {
      await _repository.remove(id: personId);
      _persistedPeople.removeWhere((person) => person.login.id == personId);
      notifyListeners();
    } catch (e) {
      // Handle error appropriately, e.g., log or show a message
    }
  }
}
