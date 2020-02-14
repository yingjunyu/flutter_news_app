import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'detail_view.dart';

class CollectionView extends StatefulWidget{
  @override
  State<StatefulWidget> createState(){
    return _CollectionViewState();
  }
}

class _CollectionViewState extends State<CollectionView>{
  List<Map<String, String>> _data = List<Map<String, String>>();
  @override
  void initState(){
    super.initState();
    _initData();
  }

  void _initData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Set<String> keys = prefs.getKeys();
    for(String key in keys){
      String value = await prefs.get(key);
      _data.add({key:value});
    }
    this.setState((){});
  }

  @override
  Widget build(BuildContext context){
    AppBar _appbar = AppBar(
      title: Text("我的收藏"),
    );
    return Scaffold(
      appBar: _appbar,
      body: Container(
        child: ListView.builder(itemBuilder: (BuildContext context, int index){
          return _buildItem(context, index);
        },
        itemCount: _data.length),
        color: Colors.black26,
      ),
    );
  }

  Widget _buildItem(BuildContext context, int index){
    return Dismissible(
      direction: DismissDirection.endToStart,
      background: new Container(color: Colors.red, child: Row(
        children: <Widget>[
          Container(
            child: Text("删除", style: TextStyle(color: Colors.white)),
            margin: EdgeInsets.only(right: 10),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.end,),),
        key: Key("$index"),
        onDismissed: (direction){
          if(direction == DismissDirection.endToStart){
            _removeDataAt(index);
          }
        },
        child: GestureDetector(
          child: Container(
            child: Center(
              child: Text(_data[index].values.last, style: TextStyle(fontSize: 15),),
            ),
            height: 60,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            margin: EdgeInsets.only(bottom: 1),
          ),
          onTap: (){
            Navigator.push(context, new MaterialPageRoute(builder: (BuildContext context){
              return DetailView(_data[index].keys.last, _data[index].values.last);
            }));
          },
        ),
    );
  }
  void _removeDataAt(int index) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove(_data[index].keys.last);
    _data.removeAt(index);
    this.setState((){});
    Fluttertoast.showToast(msg: "删除成功");
  }
}