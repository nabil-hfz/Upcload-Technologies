import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:upcload_technology/core/errors/base_error.dart';
import 'package:upcload_technology/core/params/base_params.dart';
import 'package:upcload_technology/core/results/result.dart';
import 'package:upcload_technology/core/usecases/usecase.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';
import 'package:upcload_technology/features/task_1/domain/repositories/google_map_repository.dart';

class GoogleMapParams extends BaseParams {
  GoogleMapParams({
    @required CancelToken cancelToken,
  }) : super(cancelToken: cancelToken);
}

class GoogleMapUseCase extends UseCase<List<GoogleMapDataEntity>, GoogleMapParams> {
  final GoogleMapRepository repository;

  GoogleMapUseCase(this.repository);

  @override
  Future<Result<BaseError, List<GoogleMapDataEntity>>> call(GoogleMapParams params) =>
      repository.getAllMapData(
        cancelToken: params.cancelToken,
      );
}
