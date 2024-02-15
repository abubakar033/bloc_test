import 'package:bloc_test/widgets/create_post.dart';
import 'package:bloc_test/widgets/delete_dialog.dart';
import 'package:bloc_test/widgets/list_item.dart';
import 'package:bloc_test/widgets/second_screen.dart';
import 'package:bloc_test/widgets/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/crud_bloc.dart';

class MyListScreen extends StatelessWidget {
  const MyListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CrudBloc, CrudState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == AppState.error) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Soothing Went wrong"),
            duration: Duration(milliseconds: 300),
          ));
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My List'),
          actions: [
            TextButton(
              child: const Text("Next Screen" ,style: TextStyle(color: Colors.amber)),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SecondScreen()),
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<CrudBloc, CrudState>(
          builder: (context, state) {
            if (state.status == AppState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.status == AppState.success) {
              final data = state.postList;
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final item = data[index];
                  return ListItem(
                    onEdit: () => showUpdateDialog(context, item),
                    onDelete: () => showDeleteDialog(context,
                        email: item.email, id: item.id),
                    item: item,
                  );
                },
              );
            }
            return const Center(
              child: Text("The List is Empty"),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            showCreateDialog(context);
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
