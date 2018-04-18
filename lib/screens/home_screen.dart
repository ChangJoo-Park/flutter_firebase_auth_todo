import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_firebase_auth_app/store.dart' as store;
import 'package:flutter_firebase_auth_app/models/article.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new HomeScreenState();
  }
}

class HomeScreenState extends State<HomeScreen> {
  DataSnapshot snapshot;
  var sources;
  List<Article> articles = [];

  Future getData() async {
    var snap = await store.articleSourcesDatabaseReference.once();
    if (mounted) {
      this.setState(() {
        snapshot = snap;

        if (snapshot.value == null) {
          store.articleSourcesDatabaseReference.push().set({
            'title': 'Hello',
            'body': 'World',
          });
        } else {
          print('home snapshot');
          snapshot.value.forEach((k, v) {
            articles.add(new Article(k, v['title'], v['body']));
          });
        }
      });
    }
    return "Success!";
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Home"),
        actions: <Widget>[
          new IconButton(
            icon: new Icon(Icons.exit_to_app),
            onPressed: () async {
              Navigator.of(context).pushReplacementNamed('/login');
            },
          ),
        ],
      ),
      body: new Center(
        child: snapshot == null
            ? new CircularProgressIndicator()
            : new ListView.builder(
                itemBuilder: _buildArticleList,
                itemCount: articles.length,
              ),
      ),
    );
  }

  Widget _buildArticleList(context, index) {
    return new ArticleItemWidget(articles[index]);
  }
}

class ArticleItemWidget extends StatelessWidget {
  final Article item;

  const ArticleItemWidget(this.item);

  Widget _buildTiles(BuildContext context, Article item) {
    return new ListTile(
      title: new Text(item.title),
      subtitle: new Text(item.body),
      onTap: () => print('hello'),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTiles(context, item);
  }
}
