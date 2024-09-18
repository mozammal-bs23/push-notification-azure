import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:push_notification_azure_rnd/message/view/my_home_page.dart';
import 'package:rxdart/rxdart.dart';

// Mock FirebaseMessaging
class MockFirebaseMessaging extends Mock implements FirebaseMessaging {}

void main() {
  group('MyHomePage', () {
    testWidgets('should update UI when receiving a Firebase message',
        (WidgetTester tester) async {
      // Create a BehaviorSubject to simulate Firebase message stream
      final messageStreamController = BehaviorSubject<RemoteMessage>();

      // Create the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: MyHomePage(),
        ),
      );

      // Simulate receiving a Firebase message
      const mockMessage = RemoteMessage(
        notification: RemoteNotification(
          title: 'Test Title',
          body: 'Test Body',
        ),
        data: {'key': 'value'},
      );

      // Emit the message into the Firebase message stream
      FirebaseMessaging.onMessage.listen((message) {
        messageStreamController.add(mockMessage);
      });

      // Let the stream and UI update process
      await tester.pump();

      // Verify the UI is updated with the message
      expect(find.textContaining('Title=Test Title'), findsOneWidget);
      expect(find.textContaining('Body=Test Body'), findsOneWidget);
      expect(find.textContaining('Data: {key: value}'), findsOneWidget);

      // Close the stream after the test
      await messageStreamController.close();
    });
  });
}
