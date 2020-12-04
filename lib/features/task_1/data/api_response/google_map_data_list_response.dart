import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:upcload_technology/core/model/message_model.dart';
import 'package:upcload_technology/core/response/api_response.dart';
import 'package:upcload_technology/features/task_1/data/models/google_data_map_model.dart';

part 'google_map_data_list_response.g.dart';

@JsonSerializable()
class GoogleMapDataListResponse extends ApiResponse<List<GoogleMapDataModel>> {
  final bool isOk;
  final MessageModel message;
  final List<GoogleMapDataModel> result;

  GoogleMapDataListResponse({
    @required this.isOk,
    @required this.message,
    @required this.result,
  }) : super(isOk, message, result);

  Map<String, dynamic> toJson() => _$GoogleMapDataListResponseToJson(this);

  factory GoogleMapDataListResponse.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapDataListResponseFromJson(json);


}
