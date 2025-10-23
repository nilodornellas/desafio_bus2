import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:flutter/material.dart';

class RandomPersonDetailViewModel extends ChangeNotifier {
  final RandomPersonRepository _repository;

  RandomPersonDetailViewModel({required RandomPersonRepository repository})
    : _repository = repository;

  bool _personHasBeenPersisted = false;
  bool get personHasBeenPersisted => _personHasBeenPersisted;
  bool _isPersistingOrRemoving = false;
  bool get isPersisting => _isPersistingOrRemoving;

  Future<void> checkIfPersonIsPersisted(String personId) async {
    try {
      final people = await _repository.getAll();
      final exists = people.any((person) => person.login.id == personId);
      _personHasBeenPersisted = exists;
      notifyListeners();
    } catch (e) {
      // Handle error appropriately, e.g., log or show a message
    }
  }

  Future<void> togglePersonPersistence(RandomPerson person) async {
    if (_personHasBeenPersisted) {
      await _removeRandomPerson(person);
      _personHasBeenPersisted = false;
    } else {
      await _persistRandomPerson(person);
      _personHasBeenPersisted = true;
    }
    notifyListeners();
  }

  Future<void> _persistRandomPerson(RandomPerson person) async {
    _isPersistingOrRemoving = true;
    notifyListeners();
    try {
      await _repository.add(person);
    } catch (e) {
      // Handle error appropriately, e.g., log or show a message
    } finally {
      _isPersistingOrRemoving = false;
      notifyListeners();
    }
  }

  Future<void> _removeRandomPerson(RandomPerson person) async {
    _isPersistingOrRemoving = true;
    notifyListeners();
    try {
      await _repository.remove(id: person.login.id);
    } catch (e) {
      // Handle error appropriately, e.g., log or show a message
    } finally {
      _isPersistingOrRemoving = false;
      notifyListeners();
    }
  }
}
