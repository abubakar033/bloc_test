part of 'crud_bloc.dart';

@immutable
abstract class CrudEvent {}

class FetchDataEvent extends CrudEvent {
  final String email;
  FetchDataEvent({this.email = Constant.email});
}

class FetchDataSecondEvent extends CrudEvent {
  final String email;
  FetchDataSecondEvent(this.email);
}

class DeleteDataEvent extends CrudEvent {
  final String email;
  final int id;

  DeleteDataEvent(this.email, this.id);
}

class UpdateDataEvent extends CrudEvent {
  final dynamic modelDTO;
  final bool isSecondDTO;
  UpdateDataEvent(this.modelDTO, {this.isSecondDTO = false});
}

class CreateDataEvent extends CrudEvent {
  final dynamic modelDTO;
  CreateDataEvent(this.modelDTO);
}
