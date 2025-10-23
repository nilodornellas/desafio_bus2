import 'package:desafio_bus2/core/api/dio_http_client.dart';
import 'package:desafio_bus2/core/api/http_client.dart';
import 'package:desafio_bus2/core/database/hive_local_storage.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository.dart';
import 'package:desafio_bus2/data/repositories/random_person_repository_impl.dart';
import 'package:desafio_bus2/pages/random_person_list/random_person_list_page.dart';
import 'package:desafio_bus2/pages/random_person_list/random_person_list_view_model.dart';
import 'package:desafio_bus2/pages/random_persisted_people_list/ramdom_persisted_people_list_view_model.dart';
import 'package:desafio_bus2/pages/random_person_detail/random_person_detail_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final storage = HiveLocalStorage();
  await storage.init();

  runApp(
    MultiProvider(
      providers: [
        Provider<HttpClient>(create: (_) => DioHttpClient()),
        Provider<RandomPersonRepository>(
          create: (context) => RandomPersonRepositoryImpl(
            storage: storage,
            httpClient: context.read<HttpClient>(),
          ),
        ),
        ChangeNotifierProvider<PersonListViewModel>(
          create: (context) => PersonListViewModel(
            repository: context.read<RandomPersonRepository>(),
          ),
        ),
        ChangeNotifierProvider<RandomPersonDetailViewModel>(
          create: (context) => RandomPersonDetailViewModel(
            repository: context.read<RandomPersonRepository>(),
          ),
        ),
        ChangeNotifierProvider<RamdomPersistedPeopleListViewModel>(
          create: (context) => RamdomPersistedPeopleListViewModel(
            repository: context.read<RandomPersonRepository>(),
          ),
        ),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: const RandomPersonListPage(),
    );
  }
}
