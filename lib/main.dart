import 'package:binomi/stat/binomial.dart';
import 'package:binomi/widgets/histogram.dart';
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

  @override
  Widget build(BuildContext context) {
    final binomi = Binomial(_n, _p);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Text(
              'µ = ${binomi.mu.toStringAsFixed(2)}  σ = ${binomi.sigma.toStringAsFixed(2)}',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                alignment: AlignmentDirectional.bottomCenter,
                children: [
                  Histogram(data: binomi.cd, color: Colors.indigoAccent[200].withOpacity(0.5)),
                  Histogram(
                    data: binomi.pd,
                    colorize: (k) => binomi.inSigma(k) ? Colors.amber : Colors.amber.withOpacity(0.7),
                  ),
                ],
              ),
            ),
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
