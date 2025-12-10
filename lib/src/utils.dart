import 'dart:io';

import 'package:yaml/yaml.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

/// Loads a value from the project's pubspec.yaml using the provided key.
/// Returns null if pubspec is missing or key is not found.
dynamic getProjectPubSpecValue(String key) {
  final file = File('pubspec.yaml');

  if (!file.existsSync()) {
    stderr.writeln('pubspec.yaml not found in current directory.');
    return;
  }

  final content = file.readAsStringSync();
  final doc = loadYaml(content);

  return doc[key];
}