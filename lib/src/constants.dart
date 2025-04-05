import 'package:args/args.dart';

/// A utility class containing constants and CLI options for the AppFlow CLI tool.
class AppFlowConstants {
  /// CLI argument parser with defined options and flags.
  ///
  /// Includes:
  /// - config: path to the config file (default: 'app_flow_cli.yaml')
  /// - add: module/feature to add (default: '')
  /// - overwrite: flag to allow overwriting existing files
  /// - clean: flag to remove previously generated files/folders
  /// - help: flag to display usage information
  static dynamic helpOptions = ArgParser()
    ..addOption(
      'config',
      abbr: 'c',
      help: 'Path to config YAML file',
      defaultsTo: 'app_flow_cli.yaml',
    )
    ..addOption(
      'add',
      abbr: 'a',
      help: 'Add a new module or feature to the structure',
      defaultsTo: '',
    )
    ..addFlag(
      'overwrite',
      abbr: 'o',
      help: 'Overwrite existing files',
      defaultsTo: false,
    )
    ..addFlag(
      'clean',
      abbr: 'C',
      help: 'Remove all generated files/folders created by app_flow_cli',
    )
    ..addFlag(
      'help',
      abbr: 'h',
      help: 'Show usage information',
      negatable: false,
    );

  /// Key used to represent the structure section in the config file.
  static String structure = 'structure';

  /// Key used to represent comments in the config file.
  static String comments = 'comments';

  /// List of folders to create during the initial setup.
  static List<String> additionFolders = [
    'assets/',
    'lib/src/features/',
  ];
}