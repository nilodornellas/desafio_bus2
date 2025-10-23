import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PersonListViewModel extends ChangeNotifier {
  final RandomPersonRepository _repository;

  PersonListViewModel({required RandomPersonRepository repository})
    : _repository = repository;

  late final Ticker _ticker;
  Duration? _lastElapsed = Duration.zero;

  List<RandomPerson> _people = [];
  List<RandomPerson> get people => _people;

  bool _initialLoading = true;
  bool get isLoadingInitial => _initialLoading;

  bool _isFetching = false;
  Duration _accumulated = Duration.zero;

  Future<void> init() async {
    try {
      await getRandomPerson();

      _ticker = Ticker(_onTick)..start();
    } finally {
      _initialLoading = false;
      notifyListeners();
    }
  }

  Future<void> _onTick(Duration elapsed) async {
    final delta = elapsed - (_lastElapsed ?? Duration.zero);
    _lastElapsed = elapsed;
    _accumulated += delta;

    if (_accumulated.inSeconds >= 5 && !_isFetching) {
      _accumulated = Duration.zero;

      await getRandomPerson();
    }
  }

  Future<void> getRandomPerson() async {
    _isFetching = true;
    try {
      final newPerson = await _repository.getOne();
      if (newPerson.id.name != null) {
        _people = [..._people, newPerson];
      }
    } catch (e) {
      debugPrint('Error fetching person: $e');
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }
}
