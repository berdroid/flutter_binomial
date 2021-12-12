// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:binomi/main.dart';
import 'package:binomi/widgets/histogram.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Verify widgets present on home page', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that we have all the necessary widgets in place
    expect(find.byType(Histogram), findsNWidgets(2));
    expect(find.byType(Slider), findsNWidgets(2));
    expect(find.text('n = 10'), findsOneWidget);
    expect(find.text('p = 0.50'), findsOneWidget);
  });
}
