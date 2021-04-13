import 'package:flutter/material.dart';
import 'package:clippy_flutter/arc.dart';

class DrawPage extends StatelessWidget {
  static const routename = '/drawpage';

  @override
  Widget build(BuildContext context) {
    final screenht = MediaQuery.of(context).size.height;
    final screenwt = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('DashBoard'),
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.greenAccent,
            ),
            Positioned(
              top: 60,
              left: screenwt * 0.305,
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
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/theft.jpeg'),
                    ),
                  ),
                  height: screenwt * 0.4,
                  width: 100,
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
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage('assets/accident.jpeg'),
                    ),
                  ),
                  height: 100,
                  width: screenwt * 0.39,
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
      ),
    );
  }
}
