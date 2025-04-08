import 'package:app_flow_cli/app_flow_cli.dart';
import 'package:app_flow_cli/src/constants.dart';
import 'package:test/test.dart';

void main() {
  group('CLI Tool Tests', () async {
    final parser = AppFlowConstants.helpOptions;
    final results = parser.parse(['--add', 'structure']);

    setUp(() async {
       await AppFlow.add(results);
    });

    bool statusOk = await AppFlow.generateOk();

    test('Files generated Test', () {
      expect(statusOk, isTrue);
    });
  });
}
