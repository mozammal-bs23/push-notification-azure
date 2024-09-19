import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:push_notification_azure_rnd/l10n/l10n.dart';
import 'package:push_notification_azure_rnd/message/view/my_home_page.dart';

class MockFirebaseMessaging extends Mock implements FirebaseMessaging {
  Stream<RemoteMessage> get onMessage => super.noSuchMethod(
        Invocation.getter(#onMessage),
        returnValue: Stream<RemoteMessage>.value(
          const RemoteMessage(
            notification: RemoteNotification(
              title: 'Hello',
              body: 'Hi',
            ),
          ),
        ),
      ) as Stream<RemoteMessage>;
}

void main() {
  late StreamController<RemoteMessage> messageStreamController;
  late MockFirebaseMessaging mockFirebaseMessaging;
  late String lastMessage;

  setUp(() {
    messageStreamController = StreamController<RemoteMessage>();
    mockFirebaseMessaging = MockFirebaseMessaging();

    when(mockFirebaseMessaging.onMessage)
        .thenAnswer((_) => messageStreamController.stream);

    lastMessage = '';
  });

  testWidgets(
      'renders MyHomePage and updates UI on receiving a Firebase message',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: MyHomePage(),
      ),
    );

    mockFirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      lastMessage = 'Received a notification message: '
          'Title=${message?.notification?.title},'
          'Body=${message?.notification?.body}';
    });

    // Verify the UI updates with correct text
    expect(find.text('Last message from Firebase Messaging:'), findsOneWidget);
    expect(
      find.text(lastMessage),
      findsOneWidget,
    );
  });
}
