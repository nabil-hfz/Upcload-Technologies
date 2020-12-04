// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_map_data_list_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleMapDataListResponse _$GoogleMapDataListResponseFromJson(
    Map<String, dynamic> json) {
  return GoogleMapDataListResponse(
    isOk: json['isOk'] as bool,
    message: json['message'] == null
        ? null
        : MessageModel.fromJson(json['message'] as Map<String, dynamic>),
    result: (json['result'] as List)
        ?.map((e) => e == null
            ? null
            : GoogleMapDataModel.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$GoogleMapDataListResponseToJson(
        GoogleMapDataListResponse instance) =>
    <String, dynamic>{
      'isOk': instance.isOk,
      'message': instance.message,
      'result': instance.result,
    };
