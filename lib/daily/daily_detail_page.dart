import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';


class DailyDetailPage extends StatefulWidget {
  DailyDetailPage({Key key, this.title, this.url}) : super(key: key);
  final String title;
  final String url;

  @override
  _PageState createState() => _PageState();
}

class _PageState extends State<DailyDetailPage> {
//  bool loading = true;

//  final flutterWebViewPlugin = new FlutterWebviewPlugin();

  @override
  void initState() {
    super.initState();
//    flutterWebViewPlugin.onStateChanged.listen((state) {
//    });
//    flutterWebViewPlugin.onUrlChanged.listen((url) {
//      setState(() {
//        loading = false;
//      });
//    });
  }

  @override
  Widget build(BuildContext context) {
    return new WebviewScaffold(
      url: widget.url,
      appBar: new AppBar(
        title: Text(widget.title),
      ),
      withZoom: true,
      withLocalStorage: true,
      withJavascript: true,
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
//    flutterWebViewPlugin.dispose();
    super.dispose();
  }
}


//class RoutePageWithValue extends StatelessWidget {
//  final String lastPageName;
//
//  BuildContext context;
//
//  RoutePageWithValue(this.lastPageName);
//
//  _showDialog() {
//    showDialog<Null>(
//      context: context,
//      child: new AlertDialog(content: new Text('退出当前界面'), actions: <Widget>[
//        new FlatButton(
//            onPressed: () {
//              Navigator.pop(context);
//              Navigator.of(context).pop();
//            },
//            child: new Text('确定'))
//      ]),
//    );
//  }
//
//  Future<bool> _requestPop() {
//    _showDialog();
//    return new Future.value(false);
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    this.context = context;
//    //监听左上角返回和实体返回
//    return new WillPopScope(
//        child: new Scaffold(
//            appBar: new AppBar(
//              title: new Text('RoutePageWithValue'),
//              centerTitle: true,
//            ),
//            body: new Center(
//              child: new Text('$lastPageName'),
//            )),
//        onWillPop: _requestPop);
//  }
//}