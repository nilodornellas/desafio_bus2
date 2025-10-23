import 'package:desafio_bus2/data/models/random_person.dart';
import 'package:desafio_bus2/pages/random_persisted_people_list/ramdom_persisted_people_list_view_model.dart';
import 'package:desafio_bus2/pages/random_person_detail/random_person_detail_view_model.dart';
import 'package:desafio_bus2/pages/random_person_detail/widgets/item_section.dart';
import 'package:desafio_bus2/pages/random_person_detail/widgets/section_datail_page.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';

class RandomPersonDetailPage extends StatefulWidget {
  final RandomPerson person;

  const RandomPersonDetailPage({super.key, required this.person});

  @override
  State<RandomPersonDetailPage> createState() => _RandomPersonDetailPageState();
}

class _RandomPersonDetailPageState extends State<RandomPersonDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      context.read<RandomPersonDetailViewModel>().checkIfPersonIsPersisted(
        widget.person.login.id,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<RandomPersonDetailViewModel>(context);
    final randomPersistPeopleListViewModel =
        Provider.of<RamdomPersistedPeopleListViewModel>(context);
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes'),
        centerTitle: true,
        actions: [
          Visibility(
            visible: !viewModel.isPersisting,
            child: IconButton(
              onPressed: () async {
                await viewModel.togglePersonPersistence(widget.person);
                await randomPersistPeopleListViewModel.loadPersistedPeople();
              },
              icon: Icon(
                LucideIcons.save,
                color: viewModel.personHasBeenPersisted
                    ? Theme.of(context).colorScheme.primary
                    : Colors.black,
              ),
            ),
          ),
        ],
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
                backgroundImage: NetworkImage(widget.person.picture.large),
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    '${widget.person.name.title} ${widget.person.name.first} ${widget.person.name.last}',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    widget.person.email,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    decoration: BoxDecoration(
                      color: viewModel.personHasBeenPersisted
                          ? primaryColor
                          : null,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 3,
                    ),
                    child: Text(
                      viewModel.personHasBeenPersisted
                          ? 'Salvo!'
                          : 'Não Salvo!',
                      style: TextStyle(
                        color: viewModel.personHasBeenPersisted
                            ? Colors.white
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            SectionDetailPage(
              title: 'Informações Pessoais',
              children: [
                ItemSection(label: 'Gênero', value: widget.person.gender.label),
                ItemSection(label: 'Telefone', value: widget.person.phone),
                ItemSection(label: 'Celular', value: widget.person.cell),
                ItemSection(label: 'Nacionalidade', value: widget.person.nat),
                ItemSection(
                  label: 'ID (${widget.person.id.name})',
                  value: widget.person.id.value,
                ),
              ],
            ),
            SectionDetailPage(
              title: 'Localização',
              children: [
                ItemSection(
                  label: 'Rua',
                  value:
                      '${widget.person.location.street.name}, ${widget.person.location.street.number}',
                ),
                ItemSection(
                  label: 'Cidade',
                  value: widget.person.location.city,
                ),
                ItemSection(
                  label: 'Estado',
                  value: widget.person.location.state,
                ),
                ItemSection(
                  label: 'País',
                  value: widget.person.location.country,
                ),
                ItemSection(
                  label: 'CEP',
                  value: widget.person.location.postcode.toString(),
                ),
              ],
            ),
            SectionDetailPage(
              title: 'Login',
              children: [
                ItemSection(
                  label: 'Usuário',
                  value: widget.person.login.username,
                ),
                ItemSection(
                  label: 'Senha',
                  value: widget.person.login.password,
                ),
                ItemSection(label: 'UUID', value: widget.person.login.id),
                ItemSection(label: 'SALT', value: widget.person.login.salt),
                ItemSection(label: 'MD5', value: widget.person.login.md5),
                ItemSection(label: 'SHA1', value: widget.person.login.md5),
                ItemSection(label: 'SHA256', value: widget.person.login.md5),
              ],
            ),
            SectionDetailPage(
              title: 'Datas',
              children: [
                ItemSection(
                  label: 'Nascimento',
                  value: DateFormat(
                    'dd/MM/yyyy',
                  ).format(widget.person.dob.date),
                ),
                ItemSection(
                  label: 'Idade',
                  value: widget.person.dob.age.toString(),
                ),
                ItemSection(
                  label: 'Registrado em',
                  value: DateFormat(
                    'dd/MM/yyyy',
                  ).format(widget.person.registered.date),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
