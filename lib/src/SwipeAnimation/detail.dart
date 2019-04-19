import './data.dart';
import 'package:flutter/material.dart';
import './styles.dart';
import 'package:flutter/scheduler.dart';

class DetailPage extends StatefulWidget {
  // final DecorationImage type;
  final String headlines; 
  final String description; 
  // final String source; 
  final DecorationImage img;
  
  const DetailPage({Key key, this.headlines, this.description, this.img}) : super(key: key);
  @override
  _DetailPageState createState() => new _DetailPageState(headlines : headlines, 
  description: description, 
  img: img);
}

enum AppBarBehavior { normal, pinned, floating, snapping }

class _DetailPageState extends State<DetailPage> with TickerProviderStateMixin {
  AnimationController _containerController;
  Animation<double> width;
  Animation<double> heigth;
  // DecorationImage type;
  String headlines;
  String description; 
  DecorationImage img;
  _DetailPageState({this.headlines, this.description, this.img});
  List data = imageData;
  double _appBarHeight = 256.0;
  AppBarBehavior _appBarBehavior = AppBarBehavior.pinned;

  void initState() {
    _containerController = new AnimationController(
        duration: new Duration(milliseconds: 2000), vsync: this);
    super.initState();
    width = new Tween<double>(
      begin: 200.0,
      end: 220.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth = new Tween<double>(
      begin: 400.0,
      end: 400.0,
    ).animate(
      new CurvedAnimation(
        parent: _containerController,
        curve: Curves.ease,
      ),
    );
    heigth.addListener(() {
      setState(() {
        if (heigth.isCompleted) {}
      });
    });
    _containerController.forward();
  }

  @override
  void dispose() {
    _containerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 0.7;
    // int img = data.indexOf(type);
    //print("detail");
    return new Theme(
      data: new ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color.fromRGBO(106, 94, 175, 1.0),
        platform: Theme.of(context).platform,
      ),
      child: new GestureDetector(
        onTap: () {
                    Navigator.of(context).pop();
                          },
        child: Container(
        width: width.value,
        height: heigth.value,
        color: const Color.fromRGBO(106, 94, 175, 1.0),
        child: new Hero(
          tag: "img",
          child: new Card(
            color: Colors.transparent,
            child: new Container(
              alignment: Alignment.center,
              width: width.value,
              height: heigth.value,
              decoration: new BoxDecoration(
                color: Colors.white,
                borderRadius: new BorderRadius.circular(10.0),
              ),
              child: new Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: <Widget>[
                  new CustomScrollView(
                    shrinkWrap: false,
                    slivers: <Widget>[
                      new SliverAppBar(
                        elevation: 0.0,
                        forceElevated: true,
                        leading: new IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: new Icon(
                            Icons.arrow_back,
                            color: Colors.cyan,
                            size: 30.0,
                          ),
                        ),
                        expandedHeight: _appBarHeight,
                        pinned: _appBarBehavior == AppBarBehavior.pinned,
                        floating: _appBarBehavior == AppBarBehavior.floating ||
                            _appBarBehavior == AppBarBehavior.snapping,
                        snap: _appBarBehavior == AppBarBehavior.snapping,
                        flexibleSpace: new FlexibleSpaceBar(
                          title: new Text("News Details",style: new TextStyle(
                                          fontWeight: FontWeight.bold)),
                          background: new Stack(
                            fit: StackFit.expand,
                            children: <Widget>[
                              new Container(
                                width: width.value,
                                height: _appBarHeight,
                                decoration: new BoxDecoration(
                                  image: img,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      new SliverList(
                        delegate: new SliverChildListDelegate(<Widget>[
                          new Container(
                            color: Colors.white,
                            child: new Padding(
                              padding: const EdgeInsets.all(35.0),
                              child: new Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Container(
                                    padding: new EdgeInsets.only(bottom: 20.0),
                                    alignment: Alignment.center,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        border: new Border(
                                            bottom: new BorderSide(
                                                color: Colors.black12))),
                                    child: new Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        new Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.access_time,
                                              color: Colors.cyan,
                                            ),
                                            new Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: new Text("Feb 2018"),
                                            )
                                          ],
                                        ),
                                        new Row(
                                          children: <Widget>[
                                            new Icon(
                                              Icons.map,
                                              color: Colors.cyan,
                                            ),
                                            new Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: new Text("Facebook Post"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  new Padding(
                                    padding: const EdgeInsets.only(
                                        top: 16.0, bottom: 8.0),
                                    child: new Text(
                                      "ABOUT",
                                      style: new TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  new Text(headlines,style: new TextStyle(
                                          fontSize: 15, 
                                          fontFamily: "Roboto",
                                          fontWeight: FontWeight.bold)),
                                  new Text(
                                      description != null ? description : "Nothing", textAlign: TextAlign.justify,),
                                  new Container(
                                    margin: new EdgeInsets.only(top: 25.0),
                                    padding: new EdgeInsets.only(
                                        top: 5.0, bottom: 10.0),
                                    height: 120.0,
                                    decoration: new BoxDecoration(
                                        color: Colors.white,
                                        border: new Border(
                                            top: new BorderSide(
                                                color: Colors.black12))),
                    
                              )],
                            ),
                          ),
                        )]),
                      ),
                    ],
                  ),
                  new Container(
                      width: 600.0,
                      height: 80.0,
                      decoration: new BoxDecoration(
                        color: new Color.fromRGBO(121, 114, 173, 1.0),
                      ),
                      alignment: Alignment.center,
                      child: new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        // children: <Widget>[
                        //   new FlatButton(
                        //       padding: new EdgeInsets.all(0.0),
                        //       onPressed: () {},
                        //       child: new Container(
                        //         height: 60.0,
                        //         width: 130.0,
                        //         alignment: Alignment.center,
                        //         decoration: new BoxDecoration(
                        //           color: Colors.red,
                        //           borderRadius: new BorderRadius.circular(60.0),
                        //         ),
                        //         child: new Text(
                        //           "True",
                        //           style: new TextStyle(color: Colors.white),
                        //         ),
                        //       )),
                        //   new FlatButton(
                        //       padding: new EdgeInsets.all(0.0),
                        //       onPressed: () {},
                        //       child: new Container(
                        //         height: 60.0,
                        //         width: 130.0,
                        //         alignment: Alignment.center,
                        //         decoration: new BoxDecoration(
                        //           color: Colors.cyan,
                        //           borderRadius: new BorderRadius.circular(60.0),
                        //         ),
                        //         child: new Text(
                        //           "False",
                        //           style: new TextStyle(color: Colors.white),
                        //         ),
                        //       ))
                        // ],
                      ))
                ],
              ),
            ),
          ),
        ),
      ),
    ));
  }
}
