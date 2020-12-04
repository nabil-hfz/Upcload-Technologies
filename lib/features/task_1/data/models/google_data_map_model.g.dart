// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_data_map_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GoogleMapDataModel _$GoogleMapDataModelFromJson(Map<String, dynamic> json) {
  return GoogleMapDataModel(
    id: json['id'] as String,
    index: json['index'] as int,
    name: json['name'] as String,
    clinic: json['clinic'] as String,
    imageUrl: json['imageUrl'] as String,
    distance: (json['distance'] as num)?.toDouble(),
    profession: json['profession'] as String,
    isLiked: json['isLiked'] as bool,
    isSaved: json['isSaved'] as bool,
    lat: (json['lat'] as num)?.toDouble(),
    lan: (json['lan'] as num)?.toDouble(),
    rate: (json['rate'] as num)?.toDouble(),
    price: (json['price'] as num)?.toInt(),
  );
}

Map<String, dynamic> _$GoogleMapDataModelToJson(GoogleMapDataModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'name': instance.name,
      'clinic': instance.clinic,
      'distance': instance.distance,
      'imageUrl': instance.imageUrl,
      'profession': instance.profession,
      'isLiked': instance.isLiked,
      'isSaved': instance.isSaved,
      'lat': instance.lat,
      'lan': instance.lan,
      'rate': instance.rate,
      'price': instance.price,
    };
