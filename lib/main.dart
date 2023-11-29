import 'package:binomi/stat/binomial.dart';
import 'package:charts_painter/chart.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Binomial Verteilung',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Binomial Verteilung'),
    );
  }

  /// Constructor provides [key] to super class constructor
  const MyApp({Key? key}) : super(key: key);
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Chart(
                state: ChartState(
                  data: ChartData<void>([
                    binomi.cd.map((e) => ChartItem<void>(e)).toList(),
                    binomi.pd.map((e) => ChartItem<void>(e)).toList(),
                  ]),
                  itemOptions: BarItemOptions(barItemBuilder: (ItemBuilderData d) {
                    if (d.listIndex == 0) {
                      return BarItem(
                        color: Colors.indigoAccent[200]!.withOpacity(0.5),
                      );
                    } else {
                      return BarItem(
                        color: binomi.inSigma(d.itemIndex) ? Colors.amber : Colors.amberAccent,
                      );
                    }
                  }),
                ),
              ),
            ),
          ),
          Text(
            'p = ${_p.toStringAsFixed(2)}',
            style: Theme.of(context).textTheme.titleLarge,
            textAlign: TextAlign.left,
          ),
          Slider(
            value: _p,
            onChanged: (v) => setState(() => _p = (100 * v).roundToDouble() / 100),
          ),
          Text(
            'n = $_n',
            style: Theme.of(context).textTheme.titleLarge,
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
