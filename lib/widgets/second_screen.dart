import 'package:bloc_test/bloc/crud_bloc.dart';
import 'package:bloc_test/constant.dart';
import 'package:bloc_test/widgets/delete_dialog.dart';
import 'package:bloc_test/widgets/list_item.dart';
import 'package:bloc_test/widgets/update_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({super.key});

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  void initState() {
    super.initState();
    context.read<CrudBloc>().add(FetchDataSecondEvent(Constant.email));
  }

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
      child: WillPopScope(
        onWillPop: () async {
          context.read<CrudBloc>().add(FetchDataEvent());
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              onPressed: () {
                context.read<CrudBloc>().add(FetchDataEvent());
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_ios),
            ),
            title: const Text('Second Screen List'),
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
                      onEdit: () =>
                          showUpdateDialog(context, item, isSecondScreen: true),
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
        ),
      ),
    );
  }
}
