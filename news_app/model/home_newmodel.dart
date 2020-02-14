class NewsModel{
  final int code;
  final String msg;
  final List<DataModel> newsList;
  NewsModel(this.code, this.msg, this.newsList);
  factory NewsModel.model(Map<String, dynamic> json){
    List<DataModel> list = new List<DataModel>();
    for (Map<String, dynamic> map in json["newslist"]){
      list.add(new DataModel(map["ctime"],map["title"],map["description"],map["picUrl"],map["url"]));
    }
    return new NewsModel(json["code"],json["msg"],list);
  }
}

class DataModel{
  final String ctime;
  final String title;
  final String description;
  final String picUrl;
  final String url;
  DataModel(this.ctime, this.title, this.description, this.picUrl, this.url);
}