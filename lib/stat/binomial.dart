import 'dart:math';

import 'package:binomi/stat/util.dart';

/// Represents a Binomial experiment of length [n] with probability [p]
class Binomial {
  final int n;
  final double p;

  /// The expected number of positive results
  final double mu;

  /// The standard deviation of the probability distribution
  final double sigma;

  /// Returns the probability mass distribution of the experiment
  List<double> get pd => List<double>.unmodifiable(_pd);

  /// Returns the cumulative distribution of the experiment
  List<double> get cd => List<double>.unmodifiable(_cd);

  final List<double> _pd;
  final List<double> _cd;

  Binomial(this.n, this.p)
      : mu = n * p,
        sigma = sqrt(n * p * (1 - p)),
        _pd = List<double>.filled(n + 1, 0.0),
        _cd = List<double>.filled(n + 1, 0.0) {
    double sum = 0.0;
    for (var k in Iterable.generate(n + 1)) {
      final prob = bernoulli(n, p, k);
      sum += prob;
      _pd[k] = prob;
      _cd[k] = sum;
    }
  }

  /// returns true if [k] is withing [s] [sigma] intervals of the expected value [mu]
  bool inSigma(int k, [int s = 1]) => mu - s * sigma <= k && k <= mu + s * sigma;

  /// Returns the probability of getting X positive results with k1 <= X <= k2
  double P(int k1, int k2) => _pd.sublist(k1, k2 + 1).fold(0.0, (s, p) => s + p);
}
