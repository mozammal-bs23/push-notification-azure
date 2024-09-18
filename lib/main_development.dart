import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:push_notification_azure_rnd/app/app.dart';
import 'package:push_notification_azure_rnd/bootstrap.dart';
import 'package:push_notification_azure_rnd/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load();

  await Firebase.initializeApp(
    name: 'azure-push-notification-rnd',
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final messaging = FirebaseMessaging.instance;

  final settings = await messaging.requestPermission();

  if (kDebugMode) {
    print('Permission granted: ${settings.authorizationStatus}');
  }
  final token = await messaging.getToken();

  if (kDebugMode) {
    print('Registration Token=$token');
  }
  await bootstrap(() => const App());
}
