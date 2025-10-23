import 'package:desafio_bus2/pages/random_persisted_people_list/ramdom_persisted_people_list_view_model.dart';
import 'package:desafio_bus2/pages/random_person_detail/random_person_detail_page.dart';
import 'package:desafio_bus2/presentation/states/empty_state.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
      context.read<RamdomPersistedPeopleListViewModel>().init(context);
    });
  }

  Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
    String cancelText = 'Cancelar',
    String confirmText = 'Remover',
  }) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(confirmText),
          ),
        ],
      ),
    );
    return result ?? false;
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RamdomPersistedPeopleListViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Pessoas Persistidas'), centerTitle: true),
      body: viewModel.isInitialLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ThemeData().primaryColor,
                size: 12,
              ),
            )
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
                    final result = await showConfirmDialog(
                      context,
                      title: 'Confirmar remoção',
                      message: 'Deseja realmente remover ${person.name.first}?',
                    );
                    return result;
                  },
                  onDismissed: (direction) {
                    viewModel.removePerson(context, person.login.id);
                  },
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(person.picture.medium),
                    ),
                    title: Text('${person.name.first} ${person.name.last}'),
                    subtitle: Text(person.email),
                    trailing: PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert),
                      onSelected: (value) async {
                        if (value == 'detail') {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  RandomPersonDetailPage(person: person),
                            ),
                          );
                        } else if (value == 'delete') {
                          final result = await showConfirmDialog(
                            context,
                            title: 'Confirmar remoção',
                            message:
                                'Deseja realmente remover ${person.name.first}?',
                          );
                          if (result && context.mounted) {
                            viewModel.removePerson(context, person.login.id);
                          }
                        }
                      },
                      itemBuilder: (BuildContext context) => [
                        const PopupMenuItem<String>(
                          value: 'detail',
                          child: Row(
                            children: [
                              Icon(LucideIcons.plus, size: 18),
                              SizedBox(width: 8),
                              Text('Detalhe'),
                            ],
                          ),
                        ),
                        const PopupMenuItem<String>(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                LucideIcons.trash,
                                size: 18,
                                color: Colors.red,
                              ),
                              SizedBox(width: 8),
                              Text('Remover'),
                            ],
                          ),
                        ),
                      ],
                    ),
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
