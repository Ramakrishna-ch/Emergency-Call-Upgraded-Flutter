import 'package:flutter/material.dart';
import 'package:clippy_flutter/arc.dart';
import 'package:sms_test/widgets/main_drawer.dart';
import '../rest/login.dart';
import './startup_screen.dart';
import 'package:provider/provider.dart';

class DrawPage extends StatefulWidget {
  static const routename = '/drawpage';

  @override
  _DrawPageState createState() => _DrawPageState();
}

class _DrawPageState extends State<DrawPage> {
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

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: Text('DashBoard'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.logout), onPressed: () => _showToast1(context)),
        ],
      ),
      drawer: MainDrawer(),
      body: Stack(
        children: [
          Container(
            color: Colors.greenAccent,
          ),
          Positioned(
            top: 60,
            left: screenwt * 0.305,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Arc(
                edge: Edge.BOTTOM,
                height: 30,
                child: Container(
                  child: Image(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/disaster.jpeg'),
                  ),
                  height: 100,
                  width: screenwt * 0.39,
                ),
                arcType: ArcType.CONVEY,
              ),
            ),
          ),
          Positioned(
            top: 160,
            left: 10,
            child: Arc(
              edge: Edge.RIGHT,
              height: 30,
              child: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: AssetImage('assets/fire1.jpeg'),
                  ),
                ),
                height: screenwt * 0.4,
                width: 100,
              ),
              arcType: ArcType.CONVEY,
            ),
          ),
          Positioned(
            top: 160,
            right: 10,
            child: Arc(
              edge: Edge.LEFT,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image(
                  image: AssetImage('assets/theft.jpeg'),
                  height: screenwt * 0.4,
                  width: 100,
                  fit: BoxFit.fill,
                ),
              ),
              arcType: ArcType.CONVEY,
            ),
          ),
          Positioned(
            top: screenwt * 0.4 + 160,
            left: screenwt * 0.305,
            child: Arc(
              edge: Edge.TOP,
              height: 30,
              child: ClipRRect(
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                child: Image(
                  image: AssetImage('assets/accident.jpeg'),
                  height: 100,
                  width: screenwt * 0.39,
                  fit: BoxFit.fill,
                ),
              ),
              arcType: ArcType.CONVEY,
            ),
          ),
          Positioned(
            top: 150,
            left: screenwt * 0.275,
            child: Container(
              width: screenwt * 0.45,
              height: screenwt * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: AssetImage('assets/women1.jpeg'),
                ),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
