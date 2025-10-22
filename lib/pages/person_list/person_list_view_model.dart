import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:flutter/material.dart';

class PersonListViewModel extends ChangeNotifier {
  final RandomPersonRepository _repository;

  PersonListViewModel({required RandomPersonRepository repository})
    : _repository = repository;

  List<RandomPerson> _people = [];
  List<RandomPerson> get people => _people;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> getRandomPerson() async {
    _isLoading = true;
    notifyListeners();

    try {
      final newPerson = await _repository.getOne();
      _people.add(newPerson);
    } catch (e) {
      // Handle error appropriately, e.g., log or show a message
    }

    _isLoading = false;
    notifyListeners();
  }
}
