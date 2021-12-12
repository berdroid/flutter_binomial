import 'package:flutter/material.dart';

class Histogram extends StatelessWidget {
  final List<double> data;
  final Color? color;
  final Color Function(int)? colorize;

  const Histogram({Key? key, required this.data, this.color, this.colorize}) : super(key: key);

  Color _colorize(int k) {
    if (colorize != null) {
      return colorize!(k);
    } else if (color != null) {
      return color!;
    } else {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: data
          .asMap()
          .entries
          .map((e) => Flexible(
              child: FractionallySizedBox(
                  heightFactor: e.value,
                  child: Container(
                    color: _colorize(e.key),
                  ))))
          .toList(),
    );
  }
}
