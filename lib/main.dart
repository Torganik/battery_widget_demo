import 'package:battery_level_widget/battery_level_widget.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Battery level widget demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Battery level widget demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _batteryLevel = 37;
  double _scale = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height / 3,
            child: BatteryWidget(
              bars: 4,
              scaleFactor: _scale,
              batteryLevel: _batteryLevel,
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Battery level $_batteryLevel"),
                Slider(
                  min: 0,
                  max: 100,
                  value: _batteryLevel.toDouble(),
                  onChanged: (newVal) {
                    setState(() {
                      _batteryLevel = newVal.round();
                    });
                  },
                ),
              ],
            ),
          ),
          Container(
            child: Column(
              children: [
                Text("Size level ${_scale}"),
                Slider(
                  min: 0.21,
                  max: 2,
                  value: _scale,
                  onChanged: (newVal) {
                    setState(() {
                      _scale = newVal;
                    });
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
