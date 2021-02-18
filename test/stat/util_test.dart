import 'package:binomi/stat/util.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('faculty', () {
    expect(fac(0), 1);
    expect(fac(1), 1);
    expect(fac(2), 2);
    expect(fac(3), 6);
    expect(fac(4), 24);
    expect(fac(12), 479001600);
  });

  test('permutations of 0', () {
    expect(perm(0, 0), 1);
  });

  test('permutations of 1', () {
    expect(perm(1, 0), 1);
    expect(perm(1, 1), 1);
  });

  test('permutations of 2', () {
    expect(perm(2, 0), 1);
    expect(perm(2, 1), 2);
    expect(perm(2, 2), 1);
  });

  test('permutations of 3', () {
    expect(perm(3, 0), 1);
    expect(perm(3, 1), 3);
    expect(perm(3, 2), 3);
    expect(perm(3, 3), 1);
  });

  test('permutations of 6', () {
    expect(perm(6, 0), 1);
    expect(perm(6, 1), 6);
    expect(perm(6, 2), 15);
    expect(perm(6, 3), 20);
    expect(perm(6, 4), 15);
    expect(perm(6, 5), 6);
    expect(perm(6, 6), 1);
  });

  test('bernoulli n=5, p=0.5', () {
    final n = 5;
    final p = 0.5;
    expect(bernoulli(n, p, 0), closeTo(0.0313, 0.0001));
    expect(bernoulli(n, p, 1), closeTo(0.1563, 0.0001));
    expect(bernoulli(n, p, 2), closeTo(0.3125, 0.0001));
    expect(bernoulli(n, p, 3), closeTo(0.3125, 0.0001));
    expect(bernoulli(n, p, 4), closeTo(0.1563, 0.0001));
    expect(bernoulli(n, p, 5), closeTo(0.0313, 0.0001));
  });

  test('bernoulli n=5, p=0.3', () {
    final n = 5;
    final p = 0.3;
    expect(bernoulli(n, p, 0), closeTo(0.1681, 0.0001));
    expect(bernoulli(n, p, 1), closeTo(0.3601, 0.0001));
    expect(bernoulli(n, p, 2), closeTo(0.3087, 0.0001));
    expect(bernoulli(n, p, 3), closeTo(0.1323, 0.0001));
    expect(bernoulli(n, p, 4), closeTo(0.0283, 0.0001));
    expect(bernoulli(n, p, 5), closeTo(0.0024, 0.0001));
  });
}
