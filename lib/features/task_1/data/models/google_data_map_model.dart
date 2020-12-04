import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:upcload_technology/core/model/base_model.dart';
import 'package:upcload_technology/features/task_1/domain/entities/google_data_map_entity.dart';

part 'google_data_map_model.g.dart';

@JsonSerializable()
class GoogleMapDataModel extends BaseModel<GoogleMapDataEntity> {
  final String id;
  final int index;
  final String name;
  final String clinic;
  final double distance;
  final String imageUrl;
  final String profession;
  final bool isLiked;
  final bool isSaved;
  final double lat;
  final double lan;
  final double rate;
  final int price;

  GoogleMapDataModel({
    @required this.id,
    @required this.index,
    @required this.name,
    @required this.clinic,
    @required this.imageUrl,
    @required this.distance,
    @required this.profession,
    @required this.isLiked,
    @required this.isSaved,
    @required this.lat,
    @required this.lan,
    @required this.rate,
    @required this.price,
  });

  Map<String, dynamic> toJson() => _$GoogleMapDataModelToJson(this);

  factory GoogleMapDataModel.fromJson(Map<String, dynamic> json) =>
      _$GoogleMapDataModelFromJson(json);


  @override
  GoogleMapDataEntity toEntity() {
    return GoogleMapDataEntity(
      name: name,
      index: index,
      clinic: clinic,
      distance: distance,
      id: id,
      imageUrl: imageUrl,
      isLiked: isLiked,
      isSaved: isSaved,
      profession: profession,
      lan: lan,
      lat: lat,
      rate: rate,
      price: price,
    );
  }
}
