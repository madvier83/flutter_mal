// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_mal/screens/home/home_screen.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets(
    'Home UI test',
    (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      final title1 = find.text('Top Anime');
      final title2 = find.text('This Season');
      final title3 = find.text('Upcoming');

      expect(title1, findsOneWidget);
      expect(title2, findsOneWidget);
      expect(title3, findsOneWidget);
    },
  );
}
