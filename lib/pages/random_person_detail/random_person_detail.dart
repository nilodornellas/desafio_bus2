import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/pages/random_person_detail/widgets/item_section.dart';
import 'package:desafio_bus2/pages/random_person_detail/widgets/section_datail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RandomPersonDetail extends StatelessWidget {
  final RandomPerson person;

  const RandomPersonDetail({super.key, required this.person});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        centerTitle: true,
        actions: [IconButton(onPressed: () {}, icon: Icon(LucideIcons.save))],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          spacing: 15,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(person.picture.large),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    '${person.name.title} ${person.name.first} ${person.name.last}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    person.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SectionDetailPage(
              title: 'Informações Pessoais',
              children: [
                ItemSection(label: 'Gênero', value: person.gender.label),
                ItemSection(label: 'Telefone', value: person.phone),
                ItemSection(label: 'Celular', value: person.cell),
                ItemSection(label: 'Nacionalidade', value: person.nat),
                ItemSection(
                  label: 'ID (${person.id.name})',
                  value: person.id.value,
                ),
              ],
            ),
            SectionDetailPage(
              title: 'Localização',
              children: [
                ItemSection(
                  label: 'Rua',
                  value:
                      '${person.location.street.name}, ${person.location.street.number}',
                ),
                ItemSection(label: 'Cidade', value: person.location.city),
                ItemSection(label: 'Estado', value: person.location.state),
                ItemSection(label: 'País', value: person.location.country),
                ItemSection(
                  label: 'CEP',
                  value: person.location.postCode.toString(),
                ),
              ],
            ),
            SectionDetailPage(
              title: 'Login',
              children: [
                ItemSection(label: 'Usuário', value: person.login.username),
                ItemSection(label: 'Senha', value: person.login.password),
                ItemSection(label: 'UUID', value: person.login.id),
                ItemSection(label: 'SALT', value: person.login.salt),
                ItemSection(label: 'MD5', value: person.login.md5),
                ItemSection(label: 'SHA1', value: person.login.md5),
                ItemSection(label: 'SHA256', value: person.login.md5),
              ],
            ),
            SectionDetailPage(
              title: 'Datas',
              children: [
                ItemSection(
                  label: 'Nascimento',
                  value: DateFormat('dd/MM/yyyy').format(person.dob.date),
                ),
                ItemSection(label: 'Idade', value: person.dob.age.toString()),
                ItemSection(
                  label: 'Registrado em',
                  value: DateFormat(
                    'dd/MM/yyyy',
                  ).format(person.registered.date),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
