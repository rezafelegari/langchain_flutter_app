import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:langchain_flutter_app/states/states.dart';

class BottomTextBox extends StatefulWidget {
  const BottomTextBox({
    super.key,
    required this.onSend,
  });

  final ValueChanged<String> onSend;

  @override
  State<BottomTextBox> createState() => _BottomTextBoxState();
}

class _BottomTextBoxState extends State<BottomTextBox> {
  final TextEditingController _textEditingController = TextEditingController();
  final ValueNotifier<bool> _isTextEmpty = ValueNotifier(true);

  @override
  void initState() {
    super.initState();
    _textEditingController.addListener(() {
      _isTextEmpty.value = _textEditingController.text.isEmpty;
    });
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _isTextEmpty.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QueryCubit, QueryState>(
      builder: (context, state) {
        return Stack(
          children: <Widget>[
            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                width: double.infinity,
                color: Colors.white,
                child: Row(
                  children: <Widget>[
                    BlocConsumer<UpsertCubit, UpsertState>(
                      listener: (context, state) {
                        if (state is UpsertLoaded) {
                          Fluttertoast.showToast(
                            msg: 'Uploaded Successfully',
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            backgroundColor: Colors.black.withOpacity(0.8),
                            textColor: Colors.white,
                          );
                        }
                      },
                      builder: (context, state) {
                        return RotatedBox(
                          quarterTurns: 1,
                          child: IconButton(
                              onPressed: state is UpsertLoading
                                  ? null
                                  : () {
                                      FilePicker.platform.pickFiles(
                                        type: FileType.custom,
                                        allowedExtensions: ['pdf'],
                                      ).then((value) async {
                                        if (value == null) return;
                                        String fileName = value
                                            .files.first.path!
                                            .split('/')
                                            .last;
                                        FormData formData = FormData.fromMap({
                                          "files": await MultipartFile.fromFile(
                                              value.files.first.path!,
                                              filename: fileName),
                                        });
                                        BlocProvider.of<UpsertCubit>(context)
                                            .upsertDocument(formData);
                                      });
                                    },
                              icon: Icon(
                                Icons.attachment,
                                color: state is UpsertLoading
                                    ? Colors.grey
                                    : state is UpsertLoaded
                                        ? Colors.green
                                        : Colors.black,
                              )),
                        );
                      },
                    ),
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        enabled: state is QueryLoading ? false : true,
                        decoration: const InputDecoration(
                          hintText: "Message Langchain",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    ValueListenableBuilder<bool>(
                      valueListenable: _isTextEmpty,
                      builder: (context, isTextEmpty, child) {
                        return IconButton(
                          onPressed: isTextEmpty
                              ? null
                              : () {
                                  widget.onSend(_textEditingController.text);
                                  FocusManager.instance.primaryFocus?.unfocus();
                                  BlocProvider.of<QueryCubit>(context)
                                      .askQuestion(_textEditingController.text);
                                  _textEditingController.clear();
                                },
                          icon: Icon(
                            Icons.arrow_circle_up_rounded,
                            size: 32,
                            color: isTextEmpty ? Colors.grey : Colors.black,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
