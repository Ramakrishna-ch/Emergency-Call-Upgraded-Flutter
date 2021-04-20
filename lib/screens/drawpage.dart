import 'package:flutter/material.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';
import 'package:sms_test/rest/auth.dart';
import 'package:sms_test/rest/location.dart';
import '../widgets/main_drawer.dart';

import '../rest/login.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/auth-screen';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void _showToast1(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context1) {
        return AlertDialog(
          title: Text('Logout'),
          content: Text('Are you sure?'),
          actions: [
            TextButton(
              child: Text('YES'),
              onPressed: () {
                try {
                  Provider.of<Login>(context, listen: false).logout();

                  Navigator.of(context1).pop();
                  // Navigator.of(context)
                  //     .pushReplacementNamed(StartUpScreen.routename);
                } catch (e) {
                  print(e);
                }
              },
            ),
            TextButton(
              child: Text('NO'),
              onPressed: () {
                Navigator.of(context1).pop();
              },
            ),
          ],
        );
      },
    );
  }

  FSBStatus drawerStatus;

  final Shader linearGradient = LinearGradient(
    colors: <Color>[
      Color(0xff99ccff),
      Color(0xffb3d9ff),
    ],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));
  bool isinit = true;
  @override
  void didChangeDependencies() async {
    if (isinit) {
      await Provider.of<Auth>(context, listen: false).token();
    }
    isinit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff99ccff),
        leading: IconButton(
          onPressed: () {
            setState(() {
              drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
                  ? FSBStatus.FSB_CLOSE
                  : FSBStatus.FSB_OPEN;
            });
          },
          icon: Icon(Icons.menu),
        ),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => _showToast1(context)),
        ],
      ),
      body: FoldableSidebarBuilder(
        drawerBackgroundColor: Colors.white,
        drawer: CustomDrawer(
          closeDrawer: () {
            setState(() {
              drawerStatus = FSBStatus.FSB_CLOSE;
            });
          },
        ),
        screenContents: BodyWidget(screenwt: screenwt),
        status: drawerStatus,
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.deepOrange,
          child: Icon(
            Icons.menu,
            color: Colors.white,
          ),
          onPressed: () async {
            // setState(() {
            //   drawerStatus = drawerStatus == FSBStatus.FSB_OPEN
            //       ? FSBStatus.FSB_CLOSE
            //       : FSBStatus.FSB_OPEN;
            // });
            await Provider.of<LocationClass>(context, listen: false).showloc();
          }),
    );
  }
}

// BodyWidget(screenwt: screenwt),

class BodyWidget extends StatelessWidget {
  const BodyWidget({
    Key key,
    @required this.screenwt,
  }) : super(key: key);

  final double screenwt;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [
                // Color(0xFF9ECCFA),
                // Color(0xFF91C5F8),
                // Color(0xFF6797F6),
                // Color(0xFF59AAFB),
                // Color(0xFF1B94DA),
                // Color(0xFF1892CA),
                // Color(0xFF2379CF),
                // Color(0xFF2F72B6),
                // Color(0xFF1578E9),
                // Color(0xFF2ECFD4),
                Color(0xFF6190e8),
                Color(0xFFa7bfe8),
                Color(0xFF6190e8),
                Color(0xFFa7bfe8),
                // Color(0xFF6190e8),
                // Color(0xFFa7bfe8),
                // Color(0xFF6190e8),
              ],
            ),
            // image: DecorationImage(
            //       fit: BoxFit.fill,
            //       image: AssetImage('assets/images/dp2.jpg'),
            //     ),
          ),
        ),
        Positioned(
          top: 140,
          left: screenwt * 0.305,
          child: Arc(
            edge: Edge.BOTTOM,
            height: 30,
            child: InkWell(
              onTap: () {
                print('Tapped5');
                Navigator.pushNamed(context, '/fire-screen');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.amber[900]),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/8.jpg'),
                  ),
                ),
                height: 100,
                width: screenwt * 0.394,
              ),
            ),
            arcType: ArcType.CONVEY,
          ),
        ),
        Positioned(
          top: 240,
          left: 15,
          child: Arc(
            edge: Edge.RIGHT,
            height: 30,
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, '/nature-screen');
                print('Tapped2');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.black),
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/images/tornado.png'),
                  ),
                ),
                height: screenwt * 0.4,
                width: 105,
              ),
            ),
            arcType: ArcType.CONVEY,
          ),
        ),
        Positioned(
          top: 238,
          right: 16,
          child: Arc(
            edge: Edge.LEFT,
            height: 30,
            child: InkWell(
              onTap: () {
                print('Tapped3!');
                Navigator.pushNamed(context, '/theft-screen');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.black),
                  image: DecorationImage(
                    fit: BoxFit.fitWidth,
                    image: AssetImage('assets/images/burglar.png'),
                  ),
                ),
                height: screenwt * 0.41,
                width: 104,
              ),
            ),
            arcType: ArcType.CONVEY,
          ),
        ),
        Positioned(
          top: screenwt * 0.4 + 240,
          left: screenwt * 0.305,
          child: Arc(
            edge: Edge.TOP,
            height: 30,
            child: InkWell(
              splashColor: Colors.orange,
              onTap: () {
                Navigator.pushNamed(context, '/accident-screen');
                print('Tapped4');
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(width: 5, color: Colors.green[200]),
                  image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/ambul.png'),
                  ),
                ),
                height: 100,
                width: screenwt * 0.39,
              ),
            ),
            arcType: ArcType.CONVEY,
          ),
        ),
        Positioned(
          top: 230,
          left: screenwt * 0.275,
          child: InkWell(
            splashColor: Colors.orange,
            onTap: () {
              print('Tapped5');
              Navigator.pushNamed(context, '/women-screen');
            },
            child: Container(
              width: screenwt * 0.45,
              height: screenwt * 0.45,
              decoration: BoxDecoration(
                border: Border.all(width: 8, color: Colors.red),
                image: DecorationImage(
                  // colorFilter: ColorFilter.mode(
                  //  Color(0xff006680),
                  //   BlendMode.softLight,
                  // ),
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/images/111.jpg'),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
