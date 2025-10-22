import 'package:desafio_bus2/pages/person_list/person_list_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PersonListPage extends StatelessWidget {
  const PersonListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final personListViewModel = Provider.of<PersonListViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Lista de Pessoas')),
      body: personListViewModel.isLoading
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
    );
  }
}
