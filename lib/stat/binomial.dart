import 'dart:math';

import 'package:binomi/stat/util.dart';

class Binomial {
  final int n;
  final double p;

  final double mu;
  final double sigma;
  List<double> get pd => _pd;
  List<double> get cd => _cd;

  List<double> _pd;
  List<double> _cd;

  Binomial(this.n, this.p)
      : mu = n * p,
        sigma = sqrt(n * p * (1 - p)) {
    _pd = List<double>.unmodifiable(List<double>.generate(n + 1, (k) => bernoulli(n, p, k)));
    _cd = List<double>.unmodifiable(
        List<double>.generate(n + 1, (k) => _pd.sublist(0, k + 1).fold<double>(0.0, (a, b) => a + b)));
  }

  bool inSigma(int k, [int s = 1]) => mu - s * sigma <= k && k <= mu + s * sigma;
}
