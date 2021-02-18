import 'package:binomi/stat/binomial.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
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
