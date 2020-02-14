import "dart:io";
import "package:news_app/base/base.dart";
import "dart:convert";
import "package:news_app/model/home_model.dart";
import "package:news_app/model/home_newmodel.dart";

// class NetManager{
//   Future<HomeModel> queryHomeData(int page) async{
//     var httpClient = HttpClient();
//     var uri = Uri.https(URL_DOMAIN, URL_HOME_DATA_PATH, {"key": URL_KEY, "num": "5", "page": "$page"});
//     var request = await httpClient.getUrl(uri);
//     var response = await request.close();
//     var responseBody = await response.transform(utf8.decoder).join();
//     print(responseBody);
//     return HomeModel.fromJson(json.decode(responseBody));
//   }
// }

class NetManager{
  Future<NewsModel> queryHomeData(int page) async{
    var httpClient = HttpClient();
    var uri = Uri.https(URL_DOMAIN, URL_HOME_DATA_PATH, {"key": URL_KEY, "num": "10", "page": "$page"});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print(responseBody);
    return NewsModel.model(json.decode(responseBody));
  }

  Future<NewsModel> queryCategoryData(int page, String path) async{
    var httpClient = HttpClient();
    var uri = Uri.https(URL_DOMAIN, path, {"key": URL_KEY, "num": "10", "page": "$page"});
    var request = await httpClient.getUrl(uri);
    var response = await request.close();
    var responseBody = await response.transform(utf8.decoder).join();
    print(responseBody);
    return NewsModel.model(json.decode(responseBody));
  }
}