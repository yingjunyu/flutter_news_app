import 'package:flutter/material.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news_app/tool/net_manager.dart';
//import 'package:news_app/model/home_model.dart';
import 'package:news_app/model/home_newmodel.dart';
//import 'package:news_app/base/base.dart';
import 'package:news_app/collection/detail_view.dart';

class CategoryListView extends StatefulWidget {
  String path;
  String word;
  CategoryListView(this.path, this.word);
  @override
  _CategoryListViewState createState() => _CategoryListViewState(path, word);
}

class _CategoryListViewState extends State<CategoryListView> {
  NetManager _netManager = NetManager(); //网络对象
  ScrollController _scrollController; //滚动条对象
  //List<HomeData> _datalist = List<HomeData>();
  List<DataModel> _datalist = List<DataModel>();
  int _currentPage = 1;
  String path;
  String word;
  _CategoryListViewState(this.path, this.word);
  
  @override
  void initState(){
    super.initState();
    //模拟上拉
    _scrollController = ScrollController()..addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //print("上拉");
        _requestData(_currentPage, path);
      }
    });
    _requestData(_currentPage, path);
  }
  
  @override
  Widget build(BuildContext context) {
    AppBar _appbar = AppBar(title: Text(word));
    return Scaffold(
      appBar: _appbar,
      body: Container(
        child: RefreshIndicator(
          child: ListView.builder(itemBuilder: (BuildContext context, int index){
            return _buildItem(context, index);
          },
          itemCount: this._datalist.length,
          controller: _scrollController),
        onRefresh: _onRefresh),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height - _appbar.preferredSize.height,
      color: Colors.white,
      ),
    );
  }

    //模拟下拉
  Future<Null> _onRefresh() async{
    _currentPage = 1;
    _requestData(_currentPage, path);
  }

  void _requestData(int page, String path) async{
    //print("开始请求数据");
    NewsModel data = await _netManager.queryCategoryData(page, path);
    //print(data);
    if(page == 1){
      _datalist.clear();
      _datalist.addAll(data.newsList);
    }else{
      _datalist.addAll(data.newsList);
    }
    _currentPage++;
    this.setState(() {});
    return;
  }


  //新闻列表
  Widget _buildItem(BuildContext context, int index){
    return GestureDetector(
      child: Container(
      child: Row(
         children: <Widget>[
            Container(
              child: Image.network(_datalist[index].picUrl, width: 130, height: 110, fit: BoxFit.cover),
              //color: Colors.grey,
            ),
            Column(children: <Widget>[
              Container(
                child: Text(_datalist[index].title, overflow: TextOverflow.ellipsis, maxLines: 2, style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),),
                margin: EdgeInsets.only(left: 10, top: 10, right: 10),
                width: MediaQuery.of(context).size.width - 130 - 20,
              ),
              Container(
                child: Text(_datalist[index].description),
                margin: EdgeInsets.only(left: 10, top: 5),
              ),
              Container(
                child: Text(_datalist[index].ctime),
                margin: EdgeInsets.only(left: 10, top: 5),
              ),
            ],
              crossAxisAlignment: CrossAxisAlignment.start,
            )
        ],
      ),
      height: 110,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.only(bottom: 1),
      //color: Colors.amber,
    ),
    onTap: (){
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
        return DetailView(_datalist[index].url, _datalist[index].title);
      }));
    },
    );
  }
}