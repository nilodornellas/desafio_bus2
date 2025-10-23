import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:desafio_bus2/presentation/feedbacks/snackbar_service.dart';
import 'package:flutter/material.dart';

class RandomPersonDetailViewModel extends ChangeNotifier {
  final RandomPersonRepository _repository;

  RandomPersonDetailViewModel({required RandomPersonRepository repository})
    : _repository = repository;

  bool _personHasBeenPersisted = false;
  bool get personHasBeenPersisted => _personHasBeenPersisted;
  bool _isPersistingOrRemoving = false;
  bool get isPersisting => _isPersistingOrRemoving;

  Future<void> checkIfPersonIsPersisted(
    BuildContext context,
    String personId,
  ) async {
    try {
      final people = await _repository.getAll();
      final exists = people.any((person) => person.login.id == personId);
      _personHasBeenPersisted = exists;
      notifyListeners();
    } catch (e) {
      if (!context.mounted) return;
      SnackbarService.showError(
        context,
        'Erro ao verificar persistência da pessoa.',
      );
    }
  }

  Future<void> togglePersonPersistence(
    BuildContext context,
    RandomPerson person,
  ) async {
    if (_personHasBeenPersisted) {
      await _removeRandomPerson(context, person);
      _personHasBeenPersisted = false;
    } else {
      await _persistRandomPerson(context, person);
      _personHasBeenPersisted = true;
    }
    notifyListeners();
  }

  Future<void> _persistRandomPerson(
    BuildContext context,
    RandomPerson person,
  ) async {
    _isPersistingOrRemoving = true;
    notifyListeners();
    try {
      await _repository.add(person);
      if (!context.mounted) return;
      SnackbarService.showSuccess(context, 'Pessoa persistida com sucesso!');
    } catch (e) {
      if (!context.mounted) return;
      SnackbarService.showError(context, 'Erro ao persistir pessoa.');
    } finally {
      _isPersistingOrRemoving = false;
      notifyListeners();
    }
  }

  Future<void> _removeRandomPerson(
    BuildContext context,
    RandomPerson person,
  ) async {
    _isPersistingOrRemoving = true;
    notifyListeners();
    try {
      await _repository.remove(id: person.login.id);
      if (!context.mounted) return;
      SnackbarService.showSuccess(
        context,
        'Sucesso ao remover pessoa persistida.',
      );
    } catch (e) {
      if (!context.mounted) return;
      SnackbarService.showError(context, 'Erro ao remover pessoa persistida.');
    } finally {
      _isPersistingOrRemoving = false;
      notifyListeners();
    }
  }
}
