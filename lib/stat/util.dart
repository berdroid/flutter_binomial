import 'dart:math';

/// Computes the faculty of [n] (n!) as a double
///
/// Ex. fac(3) == 6.0
double fac(int n) => List<double>.generate(n, (i) => i + 1.0).fold<double>(1.0, (a, b) => a * b);

/// Computes the number of permutations when taking [k] elements out of [n] as a double
///
/// Ex. perm(6, 4) == 15.0
double perm(int n, int k) => fac(n) / (fac(k) * fac(n - k));

/// Computes the probability of [k] hits in a Bernoulli experiment of
/// length [n] with probability [p]
double bernoulli(int n, double p, int k) {
  return perm(n, k) * pow(p, k) * pow(1 - p, n - k);
}
