import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:langchain_flutter_app/repository/repository.dart';
import 'package:langchain_flutter_app/service_locator.dart';
import 'package:langchain_flutter_app/states/states.dart';
import 'presentation/pages/pages.dart';

void main() async {
  await GetIt.instance.allReady();
  GetIt getIt = GetIt.instance;
  await dotenv.load(fileName: ".env");
  setupLocator();
  runApp(MultiBlocProvider(
    providers: <BlocProvider<dynamic>>[
      BlocProvider<QueryCubit>(
          create: (_) => QueryCubit(getIt<LangChainRepository>())),
      BlocProvider<UpsertCubit>(
          create: (_) => UpsertCubit(getIt<LangChainRepository>())),
    ],
    child: const ChatApp(),
  ));
}

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyan),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'LangChain AI'),
    );
  }
}
