import 'package:app_flow_cli/app_flow_cli.dart';
import 'package:test/test.dart';

void main() {
  group('CLI Tool Tests', () async {
    await AppFlow.generate(add: 'structure');

    setUp(() {
      // Additional setup goes here.
    });

    bool statusOk = await AppFlow.generateOk();

    test('Files generated Test', () {
      expect(statusOk, isTrue);
    });
  });
}
