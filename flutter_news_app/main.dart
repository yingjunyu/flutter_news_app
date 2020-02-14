import 'package:flutter/material.dart';
import 'package:news_app/category/category_view.dart';
import 'package:news_app/home/home_view.dart';
import 'package:news_app/collection/collection_view.dart';

void main() => runApp(App());
class App extends StatelessWidget {
  //const App({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    //return Container()
    return MaterialApp(
      debugShowCheckedModeBanner: false, //去掉debug标志
      home: _HomeView(),
    );
  }
}

class _HomeView extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      return Container(
        child: DefaultTabController(length: 2, child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              Tab(child: Text("热门", style: TextStyle(color: Colors.white)),),
              Tab(child: Text("分类", style: TextStyle(color: Colors.white)),)
            ],indicatorColor: Colors.green,),
          title: Text("新闻资讯", style: TextStyle(color: Colors.white),),
          actions: <Widget>[
            GestureDetector(
              child: Container(
                child: Icon(Icons.collections,),
                width: 60,
              ),
              onTap: (){
                Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
                  return CollectionView();
                }));
              },
            )
          ],
          ),
          body: TabBarView(children: [HomeView(), CategoryView()]),
        )),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
      );
    }
  }
