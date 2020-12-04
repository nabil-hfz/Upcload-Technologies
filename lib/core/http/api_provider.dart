import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:upcload_technology/core/http/http.dart';
import 'package:upcload_technology/features/task_1/data/api_response/google_map_data_list_response.dart';

import '../errors/bad_request_error.dart';
import '../errors/base_error.dart';
import '../errors/cancel_error.dart';
import '../errors/conflict_error.dart';
import '../errors/forbidden_error.dart';
import '../errors/http_error.dart';
import '../errors/internal_server_error.dart';
import '../errors/net_error.dart';
import '../errors/not_found_error.dart';
import '../errors/socket_error.dart';
import '../errors/timeout_error.dart';
import '../errors/unauthorized_error.dart';
import '../errors/unknown_error.dart';
import 'models_factory.dart';

class ApiProvider {


  static Future<Either<BaseError, T>> sendObjectRequest<T>({
    @required HttpMethod method,
    @required String url,
    Map<String, dynamic> data,
    Map<String, String> headers,
    Map<String, dynamic> queryParameters,
    CancelToken cancelToken,
    bool isRequestFromLocal,
  }) async {
    assert(method != null);
    assert(url != null);
    try {
      print('--------------------  Start Request Body  --------------------'
          ' \n The HttpMethod & URL are : [$method: $url]');
      print('The sended Object Request is : $data');
      print('The headers is : $headers');
      print('The queryParameters is : $queryParameters \n '
          '--------------------  End Request Body  --------------------'
          ' \n');

      // Get the response from the server
      Response response;
      String localResponse;
      if (isRequestFromLocal) {
        localResponse =
            await rootBundle.loadString(url);
      } else {
        switch (method) {
          case HttpMethod.GET:
            response = await Dio().get(
              url,
              queryParameters: queryParameters,
              options: Options(headers: headers),
              cancelToken: cancelToken,
            );
            break;
          case HttpMethod.POST:
            response = await Dio().post(
              url,
              data: data,
              queryParameters: queryParameters,
              options: Options(
                headers: headers
                  ..putIfAbsent("contentType", () => 'application/json'),
              ),
              cancelToken: cancelToken,
            );
            break;
          case HttpMethod.PUT:
            response = await Dio().put(
              url,
              data: data,
              queryParameters: queryParameters,
              options: Options(headers: headers),
              cancelToken: cancelToken,
            );
            break;
          case HttpMethod.DELETE:
            response = await Dio().delete(
              url,
              data: data,
              queryParameters: queryParameters,
              options: Options(headers: headers),
              cancelToken: cancelToken,
            );
            break;
        }
      }
      var decodedJson;
      if (isRequestFromLocal) {
        decodedJson = json.decode(localResponse);
        if (localResponse is String)
          decodedJson = json.decode(localResponse);
        else
          decodedJson = localResponse;
        print('The decodedJson is : \n ${decodedJson} \n'
            '--------------------  End Response Body  --------------------'
            ' \n');
        return Right(GoogleMapDataListResponse.fromJson(decodedJson) as T);
      } else {
        if (response.data is String)
          decodedJson = json.decode(response.data);
        else
          decodedJson = response.data;
      }
      print('\n--------------------  Start Response Body  --------------------'
          ' \n The HttpMethod & URL are : [$method: $url]');

      print('The decodedJson is : \n ${decodedJson is String} \n'
          '--------------------  End Response Body  --------------------'
          ' \n');
      // Return the http response with actual data
      return Right(ModelsFactory.getInstance().createModel<T>(decodedJson));
    }

    // Handling errors
    on DioError catch (e) {
      print('Exception is DioError $e');
      print('Exception is DioError message ${e.message}');
      print('Exception is DioError request.headers ${e.request.headers}');
      print('Exception is DioError error ${e.error}');
      print('Exception is DioError request.data ${e.request.data}');
      print('Exception is DioError headers ${e.request.headers['location']}');
      print('Exception is DioError path ${e.request.path}');
      print('Exception is DioError response ${e.response}');
      return Left(_handleDioError(e));
    }

    // Couldn't reach out the server
    on SocketException catch (e, stacktrace) {
      print(e);
      print(stacktrace);
      return Left(SocketError());
    }
  }


  static BaseError _handleDioError(DioError error) {
    if (error.type == DioErrorType.DEFAULT ||
        error.type == DioErrorType.RESPONSE) {
      if (error is SocketException) return SocketError();
      if (error.type == DioErrorType.RESPONSE) {
        switch (error.response.statusCode) {
          case 400:
            return BadRequestError();
          case 401:
            return UnauthorizedError();
          case 403:
            return ForbiddenError();
          case 404:
            return NotFoundError();
          case 409:
            return ConflictError();
          case 500:
            return InternalServerError();
          default:
            return HttpError();
        }
      }
      return NetError();
    } else if (error.type == DioErrorType.CONNECT_TIMEOUT ||
        error.type == DioErrorType.SEND_TIMEOUT ||
        error.type == DioErrorType.RECEIVE_TIMEOUT) {
      return TimeoutError();
    } else if (error.type == DioErrorType.CANCEL) {
      return CancelError();
    } else
      return UnknownError();
  }
}
