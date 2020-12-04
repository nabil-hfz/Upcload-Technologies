import 'package:upcload_technology/core/errors/base_error.dart';

class ApiError extends BaseError{
  final String message;

  ApiError({this.message});
}