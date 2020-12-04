import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:polygon_clipper/polygon_clipper.dart';

enum CHILD { FIRST_WIDGET, SECOND_WIDGET, THIRD, _WIDGET }

class ShapeAnimatedScreen extends StatefulWidget {
  static const routeName = 'screens/ShapeAnimated';

  @override
  _ShapeAnimatedScreenState createState() => _ShapeAnimatedScreenState();
}

class _ShapeAnimatedScreenState extends State<ShapeAnimatedScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  CHILD state = CHILD.FIRST_WIDGET;

  initState() {
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 1400), vsync: this);
    animation = CurvedAnimation(
      parent: controller,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    );
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed && state != CHILD.THIRD) {
        setState(() {
          state = CHILD.SECOND_WIDGET;
        });
        controller.reverse();
        print('completed');
      } else if (status == AnimationStatus.dismissed) {
        setState(() {
          state = CHILD.THIRD;
        });
        print('dismissed');
        controller.forward();
      }
      // if(state == CHILD.THIRD)
      //   state = CHILD.FIRST_WIDGET;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double widthS = MediaQuery.of(context).size.width;
    double heightS = MediaQuery.of(context).size.height -
        AppBar().preferredSize.height -
        MediaQuery.of(context).viewPadding.top;
    return Scaffold(
      appBar: AppBar(
        title: Text('Animated Widgets Demo'),
      ),
      body: Center(
        child: FadeTransition(
          opacity: animation,
          child: state == CHILD.FIRST_WIDGET
              ? Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue[200],
                        Colors.blue[800],
                      ],
                    ),
                    color: Colors.grey,
                  ),
                )
              : (state == CHILD.SECOND_WIDGET)
                  ? ClipPolygon(
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              Colors.blue[200],
                              Colors.blue[800],
                            ],
                          ),
                        ),
                      ),
                      boxShadows: [
                        PolygonBoxShadow(color: Colors.black, elevation: 5.0),
                      ],
                      sides: 6,
                      borderRadius: 5.0,
                    )
                  : Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(120),
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Colors.blue[200],
                            Colors.blue[800],
                          ],
                        ),
                      ),
                    ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.forward();
        },
        tooltip: 'Toggle Opacity',
        child: Icon(Icons.flip),
      ),
    );
  }
}
