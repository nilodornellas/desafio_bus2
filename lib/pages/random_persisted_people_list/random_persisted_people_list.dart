import 'package:desafio_bus2/pages/random_persisted_people_list/ramdom_persisted_people_list_view_model.dart';
import 'package:desafio_bus2/pages/random_person_detail/random_person_detail_page.dart';
import 'package:desafio_bus2/presentation/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class RandomPersistedPeopleList extends StatefulWidget {
  const RandomPersistedPeopleList({super.key});

  @override
  State<RandomPersistedPeopleList> createState() =>
      _RandomPersistedPeopleListState();
}

class _RandomPersistedPeopleListState extends State<RandomPersistedPeopleList> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<RamdomPersistedPeopleListViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RamdomPersistedPeopleListViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Pessoas Salvas'), centerTitle: true),
      body: viewModel.isInitialLoading
          ? Center(child: CircularProgressIndicator())
          : viewModel.persistedPeople.isEmpty
          ? EmptyState(
              icon: LucideIcons.users,
              message: 'Nenhuma pessoa salva!',
            )
          : ListView.builder(
              itemCount: viewModel.persistedPeople.length,
              itemBuilder: (context, index) {
                final person = viewModel.persistedPeople[index];

                return Dismissible(
                  key: ValueKey(person.login.id),
                  direction: DismissDirection.endToStart,
                  background: Container(
                    color: Colors.red,
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: const Icon(Icons.delete, color: Colors.white),
                  ),
                  confirmDismiss: (direction) async {
                    final result = await showDialog<bool>(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Confirmar remoção'),
                        content: Text(
                          'Deseja realmente remover ${person.name.first}?',
                        ),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(false),
                            child: const Text('Cancelar'),
                          ),
                          TextButton(
                            onPressed: () => Navigator.of(context).pop(true),
                            child: const Text('Remover'),
                          ),
                        ],
                      ),
                    );
                    return result ?? false;
                  },
                  onDismissed: (direction) {
                    viewModel.removePerson(person.login.id);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(person.picture.medium),
                    ),
                    title: Text('${person.name.first} ${person.name.last}'),
                    subtitle: Text(person.email),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 20),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              RandomPersonDetailPage(person: person),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
