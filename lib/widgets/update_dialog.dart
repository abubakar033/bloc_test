import 'package:bloc_test/bloc/crud_bloc.dart';
import 'package:bloc_test/model/modelDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UpdateDialog extends StatefulWidget {
  final dynamic data;
  final bool isSecondScreen;
  const UpdateDialog({super.key, this.data, this.isSecondScreen = false});

  @override
  State<UpdateDialog> createState() => _UpdateDialogState();
}

class _UpdateDialogState extends State<UpdateDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController imgLinkController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.data.title);
    descriptionController =
        TextEditingController(text: widget.data.description);
    if (!widget.isSecondScreen) {
      imgLinkController = TextEditingController(text: widget.data.imgLink);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Update Data'),
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
          ),
          if (!widget.isSecondScreen)
            TextField(
              controller: imgLinkController,
              decoration: const InputDecoration(labelText: 'Image Link'),
            ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
          },
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: widget.isSecondScreen
              ? null
              : () {
                  if (titleController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      imgLinkController.text.isNotEmpty) {
                    var updatedModel = ModelDTO(
                      id: widget.data.id,
                      title: titleController.text,
                      description: descriptionController.text,
                      imgLink: imgLinkController.text,
                      email: widget.data.email,
                    );
                    context.read<CrudBloc>().add(UpdateDataEvent(updatedModel,
                        isSecondDTO: widget.isSecondScreen));
                  }
                  Navigator.of(context).pop();
                },
          child: const Text('Update'),
        ),
      ],
    );
  }
}

void showUpdateDialog<T>(BuildContext context, T data,
    {bool isSecondScreen = false}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return UpdateDialog(
        data: data,
        isSecondScreen: isSecondScreen,
      );
    },
  );
}
