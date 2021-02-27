import 'dart:math';

import 'package:binomi/stat/util.dart';

class Binomial {
  final int n;
  final double p;

  final double mu;
  final double sigma;
  List<double> get pd => List<double>.unmodifiable(_pd);
  List<double> get cd => List<double>.unmodifiable(_cd);

  final List<double> _pd;
  final List<double> _cd;

  Binomial(this.n, this.p)
      : mu = n * p,
        sigma = sqrt(n * p * (1 - p)),
        _pd = List<double>.filled(n + 1, null),
        _cd = List<double>.filled(n + 1, null) {
    double sum = 0.0;
    Iterable.generate(n + 1).forEach((k) {
      final prob = bernoulli(n, p, k);
      sum += prob;
      _pd[k] = prob;
      _cd[k] = sum;
    });
  }

  bool inSigma(int k, [int s = 1]) => mu - s * sigma <= k && k <= mu + s * sigma;
}
