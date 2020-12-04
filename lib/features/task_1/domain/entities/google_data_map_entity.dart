import 'package:flutter/foundation.dart';
import 'package:upcload_technology/core/entity/base_entity.dart';

class GoogleMapDataEntity extends BaseEntity {
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
  GoogleMapDataEntity({
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

  @override
  List<Object> get props => [
        this.id,
        this.index,
        this.name,
        this.clinic,
        this.imageUrl,
        this.distance,
        this.profession,
        this.isLiked,
        this.isSaved,
        this.lat,
        this.lan,
        this.rate,
        this.price,
      ];
}
