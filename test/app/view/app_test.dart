import 'package:flutter_test/flutter_test.dart';
import 'package:push_notification_azure_rnd/app/app.dart';
import 'package:push_notification_azure_rnd/counter/counter.dart';

void main() {
  group('App', () {
    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
