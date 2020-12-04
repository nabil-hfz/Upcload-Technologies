import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:upcload_technology/core/errors/base_error.dart';
import 'package:upcload_technology/core/remote_data_source/remote_data_source.dart';
import 'package:upcload_technology/features/task_1/data/models/google_data_map_model.dart';

abstract class GoogleMapRemoteDataSource extends RemoteDataSource {
  Future<Either<BaseError, List<GoogleMapDataModel>>> fetchAllDataMap({
    CancelToken cancelToken,
  });
}
