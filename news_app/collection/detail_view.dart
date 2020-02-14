import 'package:flutter/material.dart';
import 'package:flutter_native_web/flutter_native_web.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DetailView extends StatefulWidget {
  String url;
  String title;
  DetailView(this.url, this.title);
  @override
  State<StatefulWidget> createState(){
    return _DetailViewState(url, title);
  }
}

class _DetailViewState extends State<DetailView> {
  String url;
  String title;
  _DetailViewState(this.url, this.title);
  WebController _controller;
  @override
  Widget build(BuildContext context) {
    AppBar _appbar = AppBar(
      title: Text(title),
      actions: <Widget>[
        GestureDetector(
          child: Container(child: Icon(Icons.add), width: 60),
          onTap: (){
            showDialog(context: context, builder: (BuildContext context){
              return new AlertDialog(
                title: new Text("是否收藏？"),
                actions: <Widget>[
                  new FlatButton(
                    child: new Text("确定"),
                    onPressed: (){
                      _addCollection();
                      Navigator.of(context).pop();
                    },
                  ),
                  new FlatButton(
                    child: new Text("取消"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              );
            });
          },
        )
      ],
    );
    return Scaffold(
      appBar: _appbar,
      body: Container(
        child: FlutterNativeWeb(onWebCreated: (WebController controller){
          _controller = controller;
          controller.loadUrl(this.url);
        }),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height - _appbar.preferredSize.height,
      ),
    );
  }

  void _addCollection() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String data = prefs.get(this.url);
    if(data ==  null){
      await prefs.setString(this.url, this.title);
      Fluttertoast.showToast(msg: "收藏成功");
    }else{
      Fluttertoast.showToast(msg: "该网址已经收藏过了");
    }
  }
}