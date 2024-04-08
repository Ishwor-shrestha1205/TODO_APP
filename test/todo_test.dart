import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/main.dart'; // Adjust the import path based on your project structure

void main() {
  testWidgets('Adding a todo item', (WidgetTester tester) async {
    // Build our app and trigger a frame
    await tester.pumpWidget(MyApp());

    // Verify that no todos are present initially
    expect(find.text('No todos added yet'), findsNothing);

    // Open the dialog by tapping on the floating action button
    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle(); // Wait for the dialog to open

    // Enter 'New Todo' into the text field
    await tester.enterText(find.byType(TextField), 'New Todo');

    // Tap the 'ADD' button
    await tester.tap(find.text('ADD'));
    await tester.pump(); // Trigger a frame

    // Verify the todo item appears on screen
    expect(find.text('New Todo'), findsOneWidget);
  });
}
