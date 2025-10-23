import 'package:desafio_bus2/pages/random_person_list/random_person_list_view_model.dart';
import 'package:desafio_bus2/pages/random_persisted_people_list/random_persisted_people_list.dart';
import 'package:desafio_bus2/pages/random_person_detail/random_person_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class RandomPersonListPage extends StatefulWidget {
  const RandomPersonListPage({super.key});

  @override
  State<RandomPersonListPage> createState() => _RandomPersonListPageState();
}

class _RandomPersonListPageState extends State<RandomPersonListPage> {
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      if (!mounted) return;
      context.read<PersonListViewModel>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final personListViewModel = Provider.of<PersonListViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pessoas'), centerTitle: true),
      body: personListViewModel.isLoadingInitial
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: ThemeData().primaryColor,
                size: 20,
              ),
            )
          : ListView.builder(
              itemCount: personListViewModel.people.length,
              itemBuilder: (context, index) {
                final person = personListViewModel.people[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(person.picture.medium),
                  ),
                  title: Text('${person.name.first} ${person.name.last}'),
                  subtitle: Text(person.email),
                  trailing: Icon(Icons.arrow_forward_ios, size: 20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RandomPersonDetailPage(person: person),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RandomPersistedPeopleList(),
            ),
          );
        },
        child: Icon(LucideIcons.database),
      ),
    );
  }
}
