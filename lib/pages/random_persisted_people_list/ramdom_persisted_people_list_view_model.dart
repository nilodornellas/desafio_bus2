import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:desafio_bus2/presentation/feedbacks/snackbar_service.dart';
import 'package:flutter/material.dart';

class RamdomPersistedPeopleListViewModel extends ChangeNotifier {
  final RandomPersonRepository _repository;

  RamdomPersistedPeopleListViewModel({
    required RandomPersonRepository repository,
  }) : _repository = repository;

  bool _initialLoading = true;
  bool get isInitialLoading => _initialLoading;

  bool _hasError = false;
  bool get hasError => _hasError;

  List<RandomPerson> _persistedPeople = [];
  List<RandomPerson> get persistedPeople => _persistedPeople;

  Future<void> init(BuildContext context) async {
    _initialLoading = true;
    notifyListeners();
    try {
      loadPersistedPeople();
      _hasError = false;
    } catch (e) {
      if (!context.mounted) return;
      SnackbarService.showError(
        context,
        'Erro ao carregar pessoas persistidas.',
      );
      _hasError = true;
    } finally {
      _initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPersistedPeople() async {
    _persistedPeople = await _repository.getAll();
    notifyListeners();
  }

  Future<void> removePerson(BuildContext context, String personId) async {
    try {
      await _repository.remove(id: personId);
      _persistedPeople.removeWhere((person) => person.login.id == personId);
      if (!context.mounted) return;
      SnackbarService.showSuccess(
        context,
        'Sucesso ao remover pessoa persistida.',
      );
      notifyListeners();
    } catch (e) {
      if (!context.mounted) return;
      SnackbarService.showError(context, 'Erro ao remover pessoa persistida.');
    }
  }
}
