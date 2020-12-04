import 'package:flutter/material.dart';
import 'package:upcload_technology/features/task_1/presentation/screens/google_map_screen.dart';
import 'package:upcload_technology/features/task_2/screens/animated_screen.dart';

class MiddleScreen extends StatelessWidget {
  static const routeName = 'screens/MiddleScrees';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Upcload Technology'),centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                color: Colors.amber,
                child: Text('Google Map'),
                onPressed: () {
                  Navigator.of(context).pushNamed(GoogleMapScreen.routeName);
                  },
              ),
              SizedBox(width: 12),
              RaisedButton(
                color: Colors.amber,
                child: Text('Shapes'),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(ShapeAnimatedScreen.routeName);
                },
              ),
            ],
          )
        ],
      ),
    );
  }
}
