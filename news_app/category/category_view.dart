import 'package:flutter/material.dart';
import 'package:news_app/base/base.dart';
import 'category_list_view.dart';

class CategoryView extends StatefulWidget {
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  List<String> _categorys = ["社会新闻","军事新闻","科技新闻","财经新闻","体育新闻","汽车新闻"];
  
  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
       child: ListView.builder(
         itemBuilder: (BuildContext context, int index){
           return _getItem(context, index);
         },
         itemCount: _categorys.length ~/ 2),
    );
  }

  Widget _getItem(BuildContext context, int index){
    return Container(
      child: Row(children: <Widget>[
        GestureDetector(
          child: Container(
            child: Center(child: Text(_categorys[index * 2], textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.white),),),
            width: MediaQuery.of(context).size.width / 2,
            color: index % 2 == 0 ? Colors.orange : Colors.blueAccent,
            height: 130,
          ),
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return CategoryListView(
                CATEGORY_PATH_ARRAY[index * 2], _categorys[index * 2]
              );
            }));
          },
        ),
        
        GestureDetector(
          child: Container(
            child: Center(child: Text(_categorys[index * 2 + 1], textAlign: TextAlign.center, style: TextStyle(fontSize: 30, color: Colors.white),),),
            width: MediaQuery.of(context).size.width / 2,
            color: index % 2 == 0 ? Colors.blueAccent : Colors.orange,
            height: 130,
          ),
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return CategoryListView(
                CATEGORY_PATH_ARRAY[index * 2 + 1], _categorys[index * 2 + 1]
              );
            }));
          },
        ),
      ],),
      width: MediaQuery.of(context).size.width,
      height: 130,
    );
  }
}