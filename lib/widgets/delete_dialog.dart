import 'package:bloc_test/bloc/crud_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void showDeleteDialog(BuildContext context,
    {required int id, required String email}) {
  Widget cancelButton = ElevatedButton(
    child: const Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  Widget deleteButton = ElevatedButton(
    child: const Text("Delete"),
    onPressed: () {
      context.read<CrudBloc>().add(DeleteDataEvent(email, id));
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: const Text("Delete"),
    content: const Text(
        "Are you sure you want to delete this item?"), // Customize your delete message
    actions: [
      cancelButton,
      deleteButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
