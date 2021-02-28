import 'package:binomi/stat/binomial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Binomial distribution', () {
    final b1 = Binomial(5, 0.5);
    final b2 = Binomial(3, 0.05);

    test('List is unmodifiable', () {
      expect(() => b1.pd[0] = 2.0, throwsA(isA<UnsupportedError>()));
      expect(b1.pd[0], 0.03125);
      expect(() => b1.cd[2] = 2.0, throwsA(anything));
      expect(b1.cd[0], 0.03125);
    });

    test('Probability n=5, p=0.5', () {
      expect(b1.pd.length, 6);
      expect(b1.pd[0], 0.03125);
      expect(b1.pd[1], 0.15625);
      expect(b1.pd[2], 0.3125);
      expect(b1.pd[3], 0.3125);
      expect(b1.pd[4], 0.15625);
      expect(b1.pd[5], 0.03125);
    });

    test('Cumulative n=5, p=0.5', () {
      expect(b1.cd.length, 6);
      expect(b1.cd[0], 0.03125);
      expect(b1.cd[1], 0.1875);
      expect(b1.cd[2], 0.5);
      expect(b1.cd[3], 0.8125);
      expect(b1.cd[4], 0.96875);
      expect(b1.cd[5], 1.0);
    });

    test('Probability n=3, p=0.05', () {
      expect(b2.pd.length, 4);
      expect(b2.pd[0], closeTo(0.857375, 0.0000001));
      expect(b2.pd[1], closeTo(0.135375, 0.0000001));
      expect(b2.pd[2], closeTo(0.007125, 0.0000001));
      expect(b2.pd[3], closeTo(0.000125, 0.0000001));
    });

    test('Cumulative n=3, p=0.05', () {
      expect(b2.cd.length, 4);
      expect(b2.cd[0], closeTo(0.857375, 0.0000001));
      expect(b2.cd[1], closeTo(0.99275, 0.0000001));
      expect(b2.cd[2], closeTo(0.999875, 0.0000001));
      expect(b2.cd[3], closeTo(1.0, 0.0000001));
    });
  });

  group('Probabilities', () {
    test('P<n=12, p=0.2>(X)', () {
      final b = Binomial(12, 0.2);
      expect(b.P(0, 0), closeTo(0.0687, 0.00005));
      expect(b.P(0, 1), closeTo(0.2749, 0.00005));
      expect(b.P(0, 2), closeTo(0.5583, 0.00005));
      expect(b.P(0, 12), closeTo(1.0, 0.00005));
    });

    test('P<n=10, p=0.75>(X)', () {
      final b = Binomial(10, 0.75);
      expect(b.P(7, 7), closeTo(0.2503, 0.00005));
      expect(b.P(7, 8), closeTo(0.5318, 0.00005));
      expect(b.P(7, 9), closeTo(0.7196, 0.00005));
      expect(b.P(7, 10), closeTo(0.7759, 0.00005));
      expect(b.P(0, 10), closeTo(1.0, 0.00005));
    });
  });

  group('µ and σ', () {
    test('n=5, p=0.5', () {
      final bin = Binomial(5, 0.5);
      expect(bin.mu, 2.5);
      expect(bin.sigma, closeTo(1.1180, 0.0001));
    });

    test('n=96, p=0.25', () {
      final bin = Binomial(96, 0.25);
      expect(bin.mu, 24);
      expect(bin.sigma, closeTo(4.2426, 0.0001));
    });
  });

  group('σ test', () {
    test('n=96, p=0.25', () {
      final bin = Binomial(96, 0.25);
      expect(bin.inSigma(24), true);

      expect(bin.inSigma(19), false);
      expect(bin.inSigma(20, 2), true);
      expect(bin.inSigma(15, 2), false);
      expect(bin.inSigma(24, 3), true);
      expect(bin.inSigma(7, 3), false);

      expect(bin.inSigma(30), false);
      expect(bin.inSigma(30, 2), true);
      expect(bin.inSigma(35, 2), false);
      expect(bin.inSigma(35, 3), true);
      expect(bin.inSigma(40, 3), false);
    });
  });
}
