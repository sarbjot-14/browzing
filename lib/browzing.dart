library browzing;

import 'package:browzing/imageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widgets/flutter_widgets.dart';

import 'data.dart';
import 'models/Item.dart';

class Browzing extends StatefulWidget {
  static const routeName = '/browzing';

  @override
  _BrowzingState createState() => _BrowzingState();
}

class _BrowzingState extends State<Browzing> {
  VisibilityDetectorController controller = VisibilityDetectorController();
  int currentIndex = 1;
  int credits = 0;
  List<Item> itemList = new Data().itemList;
  //final ref = FirebaseStorage.instance.ref().child('allbirds');
  Future<bool> _onWillPop() {
    Navigator.of(context).pop(credits.toString());
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _onWillPop,
        child: new Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(80.0),
              child: AppBar(
                backgroundColor: Colors.teal[400],
                leading: new Container(),
                actions: <Widget>[
                  Center(child: Text("Checkout Credits")),
                  new IconButton(
                    icon: new Icon(Icons.shopping_cart),
                    onPressed: () =>
                        Navigator.of(context).pop(credits.toString()),
                  ),
                ],
                title: Text("Browzing"),
                flexibleSpace: FlexibleSpaceBar(
                  title: Text("You have ${credits.toString()} credits"),
                  titlePadding: EdgeInsets.fromLTRB(0, 65, 0, 5),
                  centerTitle: true,
                ),
              ),
            ),
            body: ListView.builder(
                itemCount: itemList.length,
                itemBuilder: (BuildContext ctxt, int index) {
                  return new VisibilityDetector(
                    key: Key(itemList[index].id),
                    onVisibilityChanged: (VisibilityInfo info) {
                      //print('${info.visibleFraction} and ${itemList[index].id}');
                      if (!itemList[index].seen) {
                        if (info.visibleFraction > 0.4) {
                          itemList[index].seenEnough++;
                          if (itemList[index].seenEnough >= 3) {
                            setState(() {
                              itemList[index].seen = true;
                              credits++;
                              //currentIndex = index + 1;
                            });
                          }
                        }
                      }
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 40, horizontal: 5),
                      height: 600,
                      child: Card(
                        color: itemList[index].seen
                            ? Colors.teal[50]
                            : Colors.white,
                        elevation: 5,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            ListTile(
                              leading: Icon(Icons.album),
                              title: Text(itemList[index].title.toString()),
                              subtitle: Text(itemList[index].id),
                            ),
                            Container(
                              child: ImageWidget(index: index + 1),
                            ),
                            ButtonBar(
                              children: <Widget>[
                                FlatButton(
                                  child: Text('BUY TICKETS'),
                                  onPressed: () {/* ... */},
                                ),
                                FlatButton(
                                  child: Text('LISTEN'),
                                  onPressed: () {/* ... */},
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                })));
  }
}
