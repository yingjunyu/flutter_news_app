// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomeModel _$HomeModelFromJson(Map<String, dynamic> json) {
  return HomeModel(
    json['code'] as int,
    json['msg'] as String,
    (json['newsList'] as List)
        ?.map((e) =>
            e == null ? null : HomeData.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$HomeModelToJson(HomeModel instance) => <String, dynamic>{
      'code': instance.code,
      'msg': instance.msg,
      'newsList': instance.newsList,
    };

HomeData _$HomeDataFromJson(Map<String, dynamic> json) {
  return HomeData(
    json['ctime'] as String,
    json['title'] as String,
    json['description'] as String,
    json['picUrl'] as String,
    json['url'] as String,
  );
}

Map<String, dynamic> _$HomeDataToJson(HomeData instance) => <String, dynamic>{
      'ctime': instance.ctime,
      'title': instance.title,
      'description': instance.description,
      'picUrl': instance.picUrl,
      'url': instance.url,
    };
