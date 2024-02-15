// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'crud_bloc.dart';

enum AppState { success, error, initial, loading }

class CrudState extends Equatable {
  final List<dynamic> postList;
  final AppState status;
  const CrudState({
    this.postList = const [],
    this.status = AppState.initial,
  });

  @override
  List<Object?> get props => [
        postList,
        status,
      ];

  CrudState copyWith({
    List<dynamic>? postList,
    AppState? status,
  }) {
    return CrudState(
      postList: postList ?? this.postList,
      status: status ?? this.status,
    );
  }
}
