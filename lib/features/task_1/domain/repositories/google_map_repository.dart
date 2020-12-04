import 'package:dio/dio.dart';
import 'package:upcload_technology/core/errors/base_error.dart';
import 'package:upcload_technology/core/repositry/repository.dart';
import 'package:upcload_technology/core/results/result.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';

abstract class GoogleMapRepository extends Repository {
  Future<Result<BaseError, List<GoogleMapDataEntity>>> getAllMapData({
     CancelToken cancelToken,
  });
}
