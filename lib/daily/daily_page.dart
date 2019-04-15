import 'package:flutter/material.dart';
import 'package:flutter_module/daily/daily_detail_page.dart';
import 'package:flutter_module/model/daily_model.dart';
import 'package:flutter_module/repository/daily_repository_impl.dart';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';

import 'package:transparent_image/transparent_image.dart';

//这是主界面，一个StatefulWidget
class DailyPage extends StatefulWidget {
  DailyPage({Key key, this.title, this.isShowToolBar}) : super(key: key);
  final String title;
  final bool isShowToolBar;

  @override
  _PageState createState() => new _PageState();
}

class _PageState extends State<DailyPage> {
  DailyRepositoryImpl _dailyRepositoryImpl;
  List<News> _newsList = new List<News>();
  int _times = 1;
  ScrollController _scrollController = new ScrollController();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _dailyRepositoryImpl = new DailyRepositoryImpl();
    _refreshData(1, false);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        print("need load more");
        _refreshData(_times, true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: new Color(0xFFEAEAEA),
      appBar: _buildAppBar(context),
      body: new RefreshIndicator(
          onRefresh: () {
            return _refreshData(1, false);
          },
          child: new ListView.builder(
            itemCount: _newsList.length + 1,
            itemBuilder: (context, index) {
              if (index == _newsList.length) {
                return _buildLoadText();
              } else {
                return _buildListItem(context, index);
              }
            },
            controller: _scrollController,
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _refreshData(++_times, false);
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
  ///生成ToolBar组件
  Widget _buildAppBar(BuildContext context) {
    if (widget.isShowToolBar)
      return new AppBar(
        title: Text(widget.title),
      );
    else
      return null;
  }

  ///生成ListView的ItemView
  Widget _buildListItem(BuildContext buildContext, int index) {
    News newsModel = _newsList[index];
    return new Container(
        height: 100.0,
        child: new GestureDetector(
          onTap: () async {
            if (Platform.isIOS) {
              if (await canLaunch(newsModel.shareUrl)) {
                await launch(newsModel.shareUrl);
              }
            } else {
              Navigator.push(
                  context,
                  new MaterialPageRoute(
                      builder: (context) => new DailyDetailPage(
                            title: newsModel.title,
                            url: newsModel.shareUrl,
                          )));
            }
          },
          child: new Card(
            child: new Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                new Container(
                  margin: new EdgeInsets.all(5.0),
                  child: new FadeInImage.memoryNetwork(
                    placeholder: kTransparentImage,
                    image: newsModel.image,
                    fit: BoxFit.cover,
                    height: 90.0,
                    width: 90.0,
                  ),
                ),
                new Expanded(
                  child: new Padding(
                    padding: new EdgeInsets.fromLTRB(0, 5.0, 5.0, 5.0),
                    child: new Text(
                      newsModel.title,
                      style: new TextStyle(
                          fontSize: 18.0, fontWeight: FontWeight.bold),
                      maxLines: 3,
                      softWrap: true,
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget _buildLoadText() {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Center(
          child: Text("加载中……"),
        ),
      ),
      color: Colors.white70,
    );
  }

  Future _refreshData(int times, bool isLoadMore) {
    if (isLoading) {
      return null;
    }
    isLoading = true;
    if (!isLoadMore) {
      _newsList.clear();
    }
    return _dailyRepositoryImpl.loadData().then((dailyModel) {
      setState(() {
        isLoading = false;
        List<News> tempList = new List<News>();
        for (int i = times; i > 0; i--) {
          tempList.addAll(dailyModel.news);
        }
        _newsList.addAll(tempList);
      });
    }).catchError((error) {
      print(error);
      isLoading = false;
      return null;
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    if (_scrollController != null) {
      _scrollController.dispose();
    }
  }
}
