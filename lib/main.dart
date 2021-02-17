import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binomial Verteilung',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Binomial Verteilung'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _n = 10;
  double _p = 0.5;

  double fac(int n) => List<double>.generate(n, (i) => i + 1.0).fold<double>(1.0, (a, b) => a * b);
  double perm(int n, int k) => fac(n) / (fac(k) * fac(n - k));
  double binomiPd(int n, double p, int k) {
    return perm(n, k) * pow(p, k) * pow(1 - p, n - k);
  }

  @override
  Widget build(BuildContext context) {
    final pd = List<double>.generate(_n + 1, (k) => binomiPd(_n, _p, k));
    final cd = List<double>.generate(_n + 1, (k) => pd.sublist(0, k + 1).fold<double>(0.0, (a, b) => a + b));
    final mu = _n * _p;
    final sigma = sqrt(_n * _p * (1 - _p));
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Text(
            'µ = ${mu.toStringAsFixed(2)}  σ = ${sigma.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Stack(
            alignment: AlignmentDirectional.bottomCenter,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: cd
                    .map((e) => Expanded(
                            child: Container(
                          height: 400 * e,
                          color: Colors.indigoAccent[100].withOpacity(0.5),
                        )))
                    .toList(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: pd
                    .map((e) => Expanded(
                            child: Container(
                          height: 400 * e,
                          color: Colors.amber.withOpacity(0.7),
                        )))
                    .toList(),
              ),
            ],
          ),
          Text(
            'p = ${_p.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.headline6,
            textAlign: TextAlign.left,
          ),
          Slider(
            value: _p,
            onChanged: (v) => setState(() => _p = (100 * v).roundToDouble() / 100),
          ),
          Text(
            'n = $_n',
            style: Theme.of(context).textTheme.headline6,
          ),
          Slider(
            value: _n.toDouble(),
            min: 2,
            max: 100,
            divisions: 100,
            onChanged: (v) => setState(() => _n = v.floor()),
          ),
        ],
      ),
    );
  }
}
