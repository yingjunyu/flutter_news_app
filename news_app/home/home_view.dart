import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:news_app/tool/net_manager.dart';
//import 'package:news_app/model/home_model.dart';
import 'package:news_app/model/home_newmodel.dart';
import 'package:news_app/collection/detail_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  NetManager _netManager = NetManager(); //网络对象
  ScrollController _scrollController; //滚动条对象
  //List<HomeData> _datalist = List<HomeData>();
  List<DataModel> _datalist = List<DataModel>();
  int _currentPage = 1;

  @override
  void initState(){
    super.initState();
    //模拟上拉
    _scrollController = ScrollController()..addListener((){
      if(_scrollController.position.pixels == _scrollController.position.maxScrollExtent){
        //print("上拉");
        _requestData(_currentPage);
      }
    });
    _requestData(_currentPage);
  }
  
  @override
  Widget build(BuildContext context) {
    return Container(
       child: RefreshIndicator(
         child: ListView.builder(
           itemBuilder: (BuildContext context, int index){
           if(index == 0){
             return _bulidSwiper(context, index);
           }else{
             return _buildItem(context, index + 2);
           }
         },
         itemCount: _getItemCount(),
         controller: _scrollController),
      onRefresh : _onRefresh),
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
    );
  }

  //轮播图聚合
  int _getItemCount(){
    if(_datalist != null && _datalist.length > 3){
      return _datalist.length - 3 + 1;
    }else{
      return 0;
    }
  }

  //模拟下拉
  Future<Null> _onRefresh() async{
    _currentPage = 1;
    _requestData(_currentPage);
  }

  void _requestData(int page) async{
    //print("开始请求数据");
    NewsModel data = await _netManager.queryHomeData(page);
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

  //轮播图
  Widget _bulidSwiper(BuildContext context,int index){
    return GestureDetector(
      child: Container(
        child: Swiper(
          pagination: SwiperPagination(),
          control: SwiperControl(),
          autoplay: true,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index){
            return Container(
            color: Colors.orange,
            width: MediaQuery.of(context).size.width,
            height: 150,
              child: Center(
                //child: Text("轮播图$index", style: TextStyle(fontSize: 50), textAlign: TextAlign.center,),
                child: Image.network(
                  _datalist[index].picUrl,
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        height: 150,
        margin: EdgeInsets.only(bottom: 5),
      ),
      onTap: (){
      Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
        return DetailView(_datalist[index].url, _datalist[index].title);
      }));
      },
    );
  }

  //新闻列表
  Widget _buildItem(BuildContext context, int index){
    return GestureDetector(
      child:Container(
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
      }
    );
  }
}