import 'package:dio/dio.dart';
import 'package:upcload_technology/core/errors/base_error.dart';
import 'package:upcload_technology/core/results/result.dart';
import 'package:upcload_technology/features/task_1/data/datasources/google_map_remote_data_source.dart';
import 'package:upcload_technology/features/task_1/data/models/google_data_map_model.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';
import 'package:upcload_technology/features/task_1/domain/repositories/google_map_repository.dart';

class ConcreteGoogleMapRepository extends GoogleMapRepository {
  final GoogleMapRemoteDataSource remoteDataSource;

  ConcreteGoogleMapRepository(this.remoteDataSource);

  @override
  Future<Result<BaseError, List<GoogleMapDataEntity>>> getAllMapData(
      {CancelToken cancelToken}) async {
    final remoteResult = await remoteDataSource.fetchAllDataMap(
      cancelToken: cancelToken,
    );

    return executeForList<GoogleMapDataModel, GoogleMapDataEntity>(
        remoteResult: remoteResult);
  }
}
