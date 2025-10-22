import 'package:desafio_bus2/pages/person_list/person_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class PersonListPage extends StatefulWidget {
  const PersonListPage({super.key});

  @override
  State<PersonListPage> createState() => _PersonListPageState();
}

class _PersonListPageState extends State<PersonListPage> {
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
      appBar: AppBar(title: Text('Lista de Pessoas')),
      body: personListViewModel.isLoadingInitial
          ? Center(child: CircularProgressIndicator())
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
                  onTap: () {},
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(LucideIcons.database),
      ),
    );
  }
}
