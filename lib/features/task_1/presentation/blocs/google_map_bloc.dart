import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:upcload_technology/core/errors/base_error.dart';
import 'package:upcload_technology/core/http/http.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';
import 'package:upcload_technology/features/task_1/domain/repositories/google_map_repository.dart';
import 'package:upcload_technology/features/task_1/domain/usecases/google_map_usecase.dart';

import '../../../../main.dart';

@immutable
abstract class GoogleMapState extends Equatable {}

class GoogleMapUninitializedState extends GoogleMapState {
  @override
  String toString() => 'GoogleMapUninitializedState';

  @override
  List<Object> get props => [];
}

class GoogleMapLoadingState extends GoogleMapState {
  @override
  String toString() => 'GoogleMapLoadingState';

  @override
  List<Object> get props => [];
}

class GoogleMapDoneState extends GoogleMapState {
  @override
  String toString() => 'GoogleMapDoneState';
  final List<GoogleMapDataEntity> list;

  GoogleMapDoneState({this.list});

  @override
  List<Object> get props => [
        this.list,
      ];
}

class GoogleMapFailureState extends GoogleMapState {
  final BaseError error;

  GoogleMapFailureState(this.error);

  @override
  String toString() => 'GoogleMapFailureState';

  @override
  List<Object> get props => [error];
}

class GoogleMapEvent {
  final CancelToken cancelToken;

  GoogleMapEvent({
    @required this.cancelToken,
  });
}

class GoogleMapBloc extends Bloc<GoogleMapEvent, GoogleMapState> {
  @override
  GoogleMapState get initialState => GoogleMapUninitializedState();

  @override
  Stream<GoogleMapState> mapEventToState(GoogleMapEvent event) async* {
    yield GoogleMapLoadingState();
    try {
      final result = await GoogleMapUseCase(locator<GoogleMapRepository>())(
        GoogleMapParams(
          cancelToken: event.cancelToken,
        ),
      );
      if (result.hasDataOnly) {
        yield GoogleMapDoneState(list: result.data);
      } else {
        print("result.error is ${result.error}");
        yield GoogleMapFailureState(result.error);
      }
    } catch (e) {
      print("result.error e is ${e}");
      yield GoogleMapFailureState(e);
    }
  }
}
