#!/usr/bin/env dart

import 'dart:io';

import 'package:app_flow_cli/app_flow_cli.dart';
import 'package:app_flow_cli/src/constants.dart';

/// --------------------------------------------
/// AppFlow CLI Tool
///
/// A command-line tool for generating and managing 
/// scalable Flutter project structures inside the `lib/` folder.
/// 
/// Features:
/// - Generate folder/file structures based on a config
/// - Add modules/files to an existing structure
/// - Overwrite existing files with a flag
/// - Clean (remove) existing generated structure
/// 
/// Usage:
///   dart run bin/app_flow_cli.dart [options]
/// 
/// Options:
///   --config <path>       Path to the YAML/JSON config file
///   --add <module>        Add a new module or feature to the structure
///   --overwrite           Overwrite existing files if they exist
///   --clean               Remove previously generated structure
///   --help                Show usage info
/// 
/// Example:
///   dart run bin/app_flow_cli.dart --config config.yaml --add auth --overwrite
///
/// --------------------------------------------

void main(List<String> arguments) async {
  final parser = AppFlowConstants.helpOptions;

  if (arguments.isEmpty) {
    print(parser.usage);
    return;
  }

  try {
    final command = arguments.isNotEmpty ? arguments.first : null;
    final results = parser.parse(arguments);

    switch (command) {
      case '--add':
        AppFlow.add(results);
        break;
      case '--clean':
        AppFlow.clean(results);
        break;
      case '--rm':
        AppFlow.remove(results);
        break;
      case 'status':
        AppFlow.status();
        break;
      case '--help':
        print(parser.usage);
        break;
      default: 
        print(parser.usage);
        break;
    } 
  }catch (e) {
    stderr.writeln('Error: $e\n\n${parser.usage}');
    exitCode = 1;
  }
}