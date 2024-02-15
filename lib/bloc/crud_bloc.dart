import 'package:bloc/bloc.dart';
import 'package:bloc_test/constant.dart';
import 'package:bloc_test/model/SecondModelClass.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import '../model/modelDTO.dart';
import '../repo/ApiRepository.dart';

part 'crud_event.dart';
part 'crud_state.dart';

class CrudBloc extends Bloc<CrudEvent, CrudState> {
  final ApiRepository _apiRepository = ApiRepository();
  CrudBloc() : super(const CrudState()) {
    on<FetchDataEvent>(_onFetchDataEvent);
    on<FetchDataSecondEvent>(_onFetchDataSecondEvent);
    on<CreateDataEvent>(_onCreateDataEvent);
    on<UpdateDataEvent>(_onUpdateDataEvent);
    on<DeleteDataEvent>(_onDeleteDataEvent);
  }

  void _onFetchDataSecondEvent(
    FetchDataSecondEvent event,
    Emitter<CrudState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppState.loading));
      final List<SecondModelDTO> data =
          await _apiRepository.fetchSecondData(event.email);
      emit(state.copyWith(postList: data, status: AppState.success));
    } catch (e) {
      emit(state.copyWith(status: AppState.error));
    }
  }

  void _onFetchDataEvent(
    FetchDataEvent event,
    Emitter<CrudState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppState.loading));
      final List<ModelDTO> data = await _apiRepository.fetchData(event.email);
      emit(state.copyWith(postList: data, status: AppState.success));
    } catch (e) {
      emit(state.copyWith(status: AppState.error));
    }
  }

  void _onDeleteDataEvent(
    DeleteDataEvent event,
    Emitter<CrudState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppState.loading));
      final text = await _apiRepository.deleteData(event.email, event.id);
      if (text == 'successful') {
        List<dynamic> postList = List.from(state.postList);
        postList.removeWhere((item) => item.id == event.id);
        emit(state.copyWith(postList: postList, status: AppState.success));
      } else {
        // Handle deletion failure
        emit(state.copyWith(status: AppState.error));
      }
    } catch (e) {
      // Handle deletion error
      emit(state.copyWith(status: AppState.error));
    }
  }

  void _onUpdateDataEvent(
    UpdateDataEvent event,
    Emitter<CrudState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppState.loading));
      final text = await _apiRepository.updateData(
        event.modelDTO.email,
        event.modelDTO.id,
        event.modelDTO.description,
        event.modelDTO.title,
        event.isSecondDTO ? null : event.modelDTO.imgLink,
      );
      if (text == 'successful') {
        List<dynamic> postList = List.from(state.postList);
        final indexToUpdate =
            postList.indexWhere((item) => item.id == event.modelDTO.id);
        if (indexToUpdate != -1) {
          if (event.isSecondDTO) {
            postList[indexToUpdate] = SecondModelDTO(
              id: event.modelDTO.id,
              title: event.modelDTO.title,
              description: event.modelDTO.description,
              email: event.modelDTO.email,
            );
          } else {
            postList[indexToUpdate] = ModelDTO(
              id: event.modelDTO.id,
              title: event.modelDTO.title,
              description: event.modelDTO.description,
              imgLink: event.modelDTO.imgLink,
              email: event.modelDTO.email,
            );
          }
        }
        emit(state.copyWith(postList: postList, status: AppState.success));
      } else {
        emit(state.copyWith(status: AppState.error));
      }
    } catch (e) {
      emit(state.copyWith(status: AppState.error));
    }
  }

  void _onCreateDataEvent(
    CreateDataEvent event,
    Emitter<CrudState> emit,
  ) async {
    try {
      emit(state.copyWith(status: AppState.loading));
      final text = await _apiRepository.createPost(
          event.modelDTO.email,
          event.modelDTO.description,
          event.modelDTO.title,
          event.modelDTO.imgLink);
      if (text == 'successful') {
        add(FetchDataEvent());
      } else {
        emit(state.copyWith(status: AppState.error));
      }
    } catch (e) {
      emit(state.copyWith(status: AppState.error));
    }
  }
}
