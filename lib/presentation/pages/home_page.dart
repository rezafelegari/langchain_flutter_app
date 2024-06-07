import 'package:langchain_flutter_app/models/models.dart';
import 'package:langchain_flutter_app/presentation/presentation.dart';
import 'package:langchain_flutter_app/states/query_feature/query_feature.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final ValueNotifier<List<Message>> _messages = ValueNotifier(<Message>[]);
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: BlocConsumer<QueryCubit, QueryState>(
        listener: (context, state) {
          if (state is QueryLoaded) {
            _messages.value = List.from(_messages.value)
              ..add(Message(text: state.data, isMe: false));
          }
        },
        builder: (context, state) {
          return Column(
            children: <Widget>[
              Expanded(
                child: ValueListenableBuilder(
                  valueListenable: _messages,
                  builder: (context, value, child) {
                    return ListView.builder(
                      itemCount: _messages.value.length,
                      itemBuilder: (context, index) {
                        return Align(
                          alignment: _messages.value[index].isMe
                              ? Alignment.centerRight
                              : Alignment.centerLeft,
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            margin: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                              color: _messages.value[index].isMe
                                  ? Colors.grey
                                  : Colors.cyan.shade700,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              _messages.value[index].text,
                              style: const TextStyle(color: Colors.white),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              BottomTextBox(
                onSend: (value) {
                  _messages.value = List.from(_messages.value)
                    ..add(Message(text: value, isMe: true));
                },
              )
            ],
          );
        },
      ),
    );
  }
}
