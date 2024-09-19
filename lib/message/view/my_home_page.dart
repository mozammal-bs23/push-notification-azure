import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:push_notification_azure_rnd/l10n/l10n.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _lastMessage = '';

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;

    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      setState(() {
        _lastMessage = 'Received a notification message: '
            'Title=${message?.notification?.title},'
            'Body=${message?.notification?.body}';
      });
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(l10.counterAppBarTitle),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Last message from Firebase Messaging:',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            Text(
              _lastMessage,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
