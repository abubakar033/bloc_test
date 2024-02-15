import 'package:bloc_test/bloc/crud_bloc.dart';
import 'package:bloc_test/model/modelDTO.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateDialog extends StatefulWidget {
  const CreateDialog({super.key});

  @override
  State<CreateDialog> createState() => _CreateDialogState();
}

class _CreateDialogState extends State<CreateDialog> {
  late TextEditingController titleController;
  late TextEditingController descriptionController;
  late TextEditingController imgLinkController;
  late TextEditingController emailController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: '');
    descriptionController = TextEditingController(text: '');
    imgLinkController = TextEditingController(text: '');
    emailController = TextEditingController(text: '');
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Create Post'),
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
          TextField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
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
          onPressed: () {
            if (titleController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty &&
                imgLinkController.text.isNotEmpty &&
                emailController.text.isNotEmpty) {
              var updatedModel = ModelDTO(
                id: 1,
                title: titleController.text,
                description: descriptionController.text,
                imgLink: imgLinkController.text,
                email: emailController.text,
              );
              context.read<CrudBloc>().add(CreateDataEvent(updatedModel));
            }
            Navigator.of(context).pop();
          },
          child: const Text('Create Post'),
        ),
      ],
    );
  }
}

void showCreateDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return const CreateDialog();
    },
  );
}
