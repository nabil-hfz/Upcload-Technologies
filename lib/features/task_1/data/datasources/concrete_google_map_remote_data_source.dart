import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:upcload_technology/core/errors/base_error.dart';
import 'package:upcload_technology/core/http/http_method.dart';
import 'package:upcload_technology/core/resources/constants.dart';
import 'package:upcload_technology/features/task_1/data/api_response/google_map_data_list_response.dart';
import 'package:upcload_technology/features/task_1/data/models/google_data_map_model.dart';

import 'google_map_remote_data_source.dart';

class ConcreteGoogleMapRemoteDataSource extends GoogleMapRemoteDataSource {
  @override
  Future<Either<BaseError, List<GoogleMapDataModel>>> fetchAllDataMap({
    CancelToken cancelToken,
  }) async {
    return request<List<GoogleMapDataModel>, GoogleMapDataListResponse>(
      responseStr: ' GoogleMapDataListResponse',
      converter: (json) => GoogleMapDataListResponse.fromJson(json),
      method: HttpMethod.GET,
      url: API_BASE,
      queryParameters: {},
      data: {},
      cancelToken: cancelToken,
      isRequestFromLocal: true
    );
  }
}
