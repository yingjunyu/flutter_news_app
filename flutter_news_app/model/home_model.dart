import "package:json_annotation/json_annotation.dart";
part "home_model.g.dart";

@JsonSerializable(nullable: true)
class HomeModel{
  int code;
  String msg;
  List<HomeData> newsList;
  HomeModel(this.code, this.msg, this.newsList);
  factory HomeModel.fromJson(Map<String, dynamic> json) => _$HomeModelFromJson(json);
  Map<String, dynamic> toJson() => _$HomeModelToJson(this);
}

@JsonSerializable(nullable: true)
class HomeData{
  String ctime;
  String title;
  String description;
  String picUrl;
  String url;
  HomeData(this.ctime, this.title, this.description, this.picUrl, this.url);
  factory HomeData.fromJson(Map<String, dynamic> json) => _$HomeDataFromJson(json);
  Map<String, dynamic> toJson() => _$HomeDataToJson(this);
}