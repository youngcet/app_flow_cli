import 'dart:developer';
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
void main(List<String> args) async {
  final parser = AppFlowConstants.helpOptions;

  try {
    final results = parser.parse(args);
    
    if (results['help'] as bool) {
      print(parser.usage);
      return;
    }

    if (args.isEmpty){
      print(parser.usage);
      return;
    }

    await AppFlow.generate(
      configPath: results['config'] as String,
      add: results['add'] as String,
      overwrite: results['overwrite'] as bool,
      clean: results['clean'] as bool,
    );
  } catch (e) {
    stderr.writeln('Error: $e\n\n${parser.usage}');
    exitCode = 1;
  }
}
