import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:app_flow_cli/src/app_flow_cli_route.dart';
import 'package:app_flow_cli/src/constants.dart';
import 'package:app_flow_cli/src/utils.dart';
import 'package:console/console.dart';
import 'package:path/path.dart' as path;
import 'package:yaml/yaml.dart';

/// Main configuration class for the AppFlow CLI tool
/// 
/// Handles project structure generation and cleanup operations based on YAML configurations.
/// Manages both default embedded configurations and user-provided custom configurations.
class AppFlow {
  /// Default embedded YAML configuration for project structure
  /// Contains predefined folder structure and template files for:
  /// - Feature modules (splash, home)
  /// - Core architecture components
  /// - Localization setup
  /// - Asset management
  /// - Testing infrastructure
  static final String _defaultConfig = '''
folders:
  # Feature modules
  # Splash Screen
  - lib/features/
  - lib/features/splash/
  - lib/features/splash/presentation/
  - lib/features/splash/logic/

  # Home Screen
  - lib/features/home/
  - lib/features/home/presentation/
  - lib/features/home/logic/
  
  # Routes
  - lib/features/routes/
  - lib/features/routes/presentation/
  - lib/features/routes/logic/

  # Core functionality
  - lib/core/
  - lib/core/services/
  - lib/core/utils/
  
  # Localization
  - lib/l10n/
  
  # Static files
  - assets/icons/
  - assets/images/
  - assets/fonts/
  - assets/translations/
  
  # Testing
  - test/features/
  - test/mock/
  - test/test_helpers/
  
  # Other
  - integration_test/
  - scripts/

files:    
  lib/features/routes/logic/router.dart: |
    {appflow.metadata}
    import 'package:flutter/material.dart';
    
    // <appflow-imports>
    import '../../splash/presentation/splash_screen.dart';     // splash screen
    import '../../home/presentation/home_screen.dart';         // home screen

    /// Centralized route management class for the application
    /// Handles route generation and navigation methods
    /// 
    /// [Auto-Generated] This class is automatically maintained by the app flow structure generator
    class Routes {
      static const String splash = '/';    // Initial route
      static const String home = '/home';     // Main screen after splash
      static const String notFound = '/404';    // 404 error page
      // <appflow-constants>

      /// Generates routes based on route settings
      /// [settings] Contains route name and arguments
      /// Returns configured MaterialPageRoute
      static Route<dynamic> generateRoute(RouteSettings settings) {
        switch (settings.name) {
          case splash:
            return MaterialPageRoute(builder: (_) => const SplashScreen());     // Splash screen widget
          case home:
            return MaterialPageRoute(builder: (_) => const HomeScreen());       // Main application screen
          // <appflow-start:route>
          // case <appflow-screen>:
          //   return MaterialPageRoute(builder: (_) => const <appflow-screen:callback>);
          // <appflow-end:route>
          default:
            return MaterialPageRoute(builder: (_) => const RouteNotFound());    // 404 error page
        }
      }

      /// Navigates to a new screen while keeping previous in stack
      /// [context] Build context for navigation
      /// [routeName] Target route from Routes constants
      /// [arguments] Optional data to pass to new route
      static void push(BuildContext context, String routeName, {Object? arguments}) {
        Navigator.pushNamed(context, routeName, arguments: arguments);
      }

      /// Replaces current screen with new route
      /// [context] Build context for navigation
      /// [routeName] Target route from Routes constants
      /// [arguments] Optional data to pass to new route
      static void replace(BuildContext context, String routeName, {Object? arguments}) {
        Navigator.pushReplacementNamed(context, routeName, arguments: arguments);
      }

      /// Clears navigation stack and makes new route first
      /// [context] Build context for navigation
      /// [routeName] Target route from Routes constants
      /// [arguments] Optional data to pass to new route
      static void makeFirst(BuildContext context, String routeName, {Object? arguments}) {
        Navigator.pushNamedAndRemoveUntil(
          context,
          routeName,
          (route) => false,
          arguments: arguments,
        );
      }
    } 

    /// Default 404 error page displayed for unknown routes
    class RouteNotFound extends StatelessWidget {
      const RouteNotFound({super.key});

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          appBar: AppBar(title: const Text('Page Not Found')),
          body: const Center(
            child: Text('The requested page does not exist'),
          ),
        );
      }
    }
  
  lib/features/splash/presentation/splash_screen.dart: |
    {appflow.metadata}
    import 'dart:async';
    import 'package:flutter/material.dart';

    import '../../routes/logic/router.dart';

    class SplashScreen extends StatefulWidget {
      const SplashScreen({super.key});

      @override
      State<SplashScreen> createState() => _SplashScreenState();
    }

    class _SplashScreenState extends State<SplashScreen> {
      @override
      void initState() {
        super.initState();
        Timer(
          const Duration(seconds: 3),
          () => Routes.makeFirst(context, Routes.home)
        );
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF0A0E21),
                  Color(0xFF1D1E33),
                ],
              ),
            ),
            child: Stack(
              children: [
                // Background code snippets
                Positioned(
                  top: 100,
                  left: 20,
                  child: Opacity(
                    opacity: 0.1,
                    child: Text(
                      'const code = "Flutter";',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontFamily: 'FiraCode',
                          ),
                    ),
                  ),
                ),
                
                // Main content
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedOpacity(
                        opacity: 1,
                        duration: const Duration(milliseconds: 500),
                        child: const Icon(
                          Icons.code,
                          size: 100,
                          color: Colors.tealAccent,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ShaderMask(
                        shaderCallback: (bounds) => const LinearGradient(
                          colors: [Colors.blue, Colors.tealAccent],
                        ).createShader(bounds),
                        child: const Text(
                          'App Flow CLI',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'FiraCode',
                            color: Colors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      const Text(
                        'Building scalable structures',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
                
                // Loading indicator
                Positioned(
                  bottom: 50,
                  left: 0,
                  right: 0,
                  child: LinearProgressIndicator(
                    backgroundColor: Colors.white24,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.tealAccent.withOpacity(0.6),
                    ),
                    minHeight: 2,
                  ),
                ),
              ],
            ),
          ),
        );
      }
    }

  lib/features/home/presentation/home_screen.dart: |
    {appflow.metadata}
    import 'dart:async';
    import 'package:flutter/material.dart';

    class HomeScreen extends StatefulWidget {
      const HomeScreen({super.key});

      @override
      State<HomeScreen> createState() => _HomeScreenState();
    }

    class _HomeScreenState extends State<HomeScreen> {
      @override
      void initState() {
        super.initState();
      }

      @override
      Widget build(BuildContext context) {
        return Scaffold(
          body: Center(
            child: const Text('Home Page', style: TextStyle(color: Colors.white),)
          ),
        );
      }
    }

  lib/main.dart: |
    {appflow.metadata}
    import 'package:flutter/material.dart';

    import 'features/routes/logic/router.dart';

    void main() {
      runApp(const MyApp());
    }

    class MyApp extends StatelessWidget {
      const MyApp({super.key});

      @override
      Widget build(BuildContext context) {
        return MaterialApp(
          title: 'App Flow CLI',
          initialRoute: Routes.splash,
          onGenerateRoute: Routes.generateRoute,
          theme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: const Color(0xFF0A0E21),
            textTheme: const TextTheme().apply(
              fontFamily: 'FiraCode',
            ),
          ),
        );
      }
    }
    
  lib/l10n/app_en.arb: |
    {
      "appTitle": "My App",
      "@appTitle": {
        "description": "The title of the application"
      }
    }
  
  .appflow_generated.json: |
    {appflow.generatedfiles}
''';

  /// Main entry point for generating or cleaning project structure
  /// Handles both creation and cleanup operations based on parameters
  static Future<void> add(dynamic options) async {
    String? feature = options[AppFlowConstants.addOption] as String;
    String configPath = options[AppFlowConstants.configOption] ?? '';
    bool overwrite = options[AppFlowConstants.overwriteOption] as bool;
    //String? page = options[AppFlowConstants.pageOption] as String;

    String targetPath = ''; // root directory
    
    if (feature == AppFlowConstants.structure){
      final externalConfig = await _loadConfig(configPath);
      final config = externalConfig ?? _parseDefaultConfig();

      final folders = (config['folders'] as List).map((e) => e.toString()).toList();
      final files = Map<String, String>.fromEntries(
        (config['files'] as Map).entries.map((e) => 
          MapEntry(e.key.toString(), e.value.toString()),
      ));

      stderr.writeln('Adding ${folders.length + files.length} items...');

      await _createFolders(targetPath, folders);
      await _createFiles(targetPath, files, overwrite);
      
    }else{
      // if not a structure, its a feature
      List<String> features = feature.split(':');
      if (! features.asMap().containsKey(1) || features[1].isEmpty){
        stderr.writeln('Invalid command. Please type appflow --help for available commands.');
        return;
      }

      String newFeature = features[0];
      List<String> newFolders = features[1].split(',');

      List<String> newStructures = [];
      final folders = await _getFeatureStructure(newFeature);
      for (var folder in newFolders){
        if (folder.isEmpty){
          continue;
        }

        newStructures.add('lib/$newFeature/$folder');
        for(var entry in folders){
          newStructures.add('lib/$newFeature/$folder/$entry');
        }
      }

      await _createFolders(targetPath, newStructures);
    }
  }

  /// Parses the default embedded YAML configuration
  /// Converts YAML structure to Dart native types
  static Map<String, dynamic> _parseDefaultConfig() {
    final yaml = loadYaml(_defaultConfig);
    return _yamlToDart(yaml);
  }

  /// Recursively converts YAML nodes to Dart objects
  /// Handles YamlMap, YamlList, and YamlScalar types
  static dynamic _yamlToDart(dynamic node) {
    if (node is YamlMap) {
      return Map<String, dynamic>.fromIterables(
        node.keys.map((k) => k.toString()),
        node.values.map(_yamlToDart),
      );
    }
    if (node is YamlList) {
      return node.map(_yamlToDart).toList();
    }
    if (node is YamlScalar) {
      return node.value;
    }
    return node.toString();
  }

  /// Loads external YAML configuration file
  /// Returns null if file not found or invalid
  static Future<Map<String, dynamic>?> _loadConfig(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        final content = await file.readAsString();
        return _yamlToDart(loadYaml(content));
      }
    } catch (e) {
      stderr.writeln('Config Error: $e');
    }
    return null;
  }

  /// Creates directories from folder paths
  /// Skips existing folders unless overwrite is true
  static Future<void> _createFolders(
    String root,
    List<String> folders,
  ) async {
    stderr.writeln('Creating ${folders.length} folder/s...');
    var progress = ProgressBar();
    var i = 0;
    for (final folder in folders) {
      i++;
      double progresscount = (i / folders.length) * 100;
      progress.update(progresscount.toInt());
      //print(progresscount.toInt());
      final dir = Directory(path.join(root, folder));
      if (!await dir.exists()) {
        await dir.create(recursive: true);
        await _trackGeneratedFile(
          path: folder,
          isFile: false
        );
      }
    }
  }

  /// Creates files with specified content
  /// Overwrites existing files if [overwrite] is true
  static Future<void> _createFiles(
    String root,
    Map<String, String> files,
    bool overwrite,
  ) async {
    stderr.writeln('Creating ${files.length} file/s...');
    var progress = ProgressBar();
    var i = 0;
    for (final entry in files.entries) {
      final file = File(path.join(root, entry.key));

      i++;
      double progresscount = (i / files.length) * 100;
      progress.update(progresscount.toInt());

      if (!await file.exists() || overwrite) {
        await file.create(recursive: true);
        await file.writeAsString(entry.value.replaceAll('{appflow.metadata}', _getMetaData()));
        await _trackGeneratedFile(
          path: entry.key,
          overwrite: overwrite,
          isFile: true
        );
        // print('${overwrite ? 'Overwrote' : 'Created'}: ${file.path}');
      }
    }
  }

  /// Cleans up generated files and folders based on configuration
  /// WARNING: Potentially destructive operation
  static Future<void> clean(dynamic options) async {
    String configPath = options[AppFlowConstants.configOption] ?? '';

    final externalConfig = await _loadConfig(configPath);
    final config = externalConfig ?? _parseDefaultConfig();
  
    final folders = (config['folders'] as List).map((e) => e.toString()).toList();
    final files = Map<String, String>.fromEntries(
      (config['files'] as Map).entries.map((e) => 
        MapEntry(e.key.toString(), e.value.toString()),
    ));

    var totalitems = folders.length + files.length;
    if (externalConfig == null){
      totalitems += AppFlowConstants.additionFolders.length;
    }
    stderr.writeln('Cleaning $totalitems items...');

    var progress = ProgressBar();
    var i = 0;
    // Reverse to clean files before folders
    for (final entry in files.entries){
      String path = entry.key;
      final file = File(path);

      i++;
      double progresscount = (i / totalitems) * 100;
      progress.update(progresscount.toInt());

      if (await file.exists() && !path.contains('main.dart')) {
        try {
          await file.delete(recursive: true);
        } catch (e) {
          stderr.writeln('Error removing $path: $e');
        }
      }
    }
    
    // add additional folder to remove
    folders.addAll(AppFlowConstants.additionFolders);
    
    for (final folder in folders){
      final dir = Directory(folder);

      i++;
      double progresscount = (i / totalitems) * 100;
      progress.update(progresscount.toInt());

      if (await dir.exists()){
        try {
          await dir.delete(recursive: true);
        } catch (e) {
          stderr.writeln('Error removing $folder: $e');
        }
      }
    }
  }

  /// Removes specified folders within a feature directory in the `lib/` folder.
  /// 
  /// Expects a string in the format `feature:folder1,folder2` from the options,
  /// where `feature` is the parent directory and `folder1,folder2` are the folders to be removed.
  static Future<void> remove(dynamic options)async{
    String remove = options[AppFlowConstants.removeOption] as String;

    List<String> features = remove.split(':');
    if (! features.asMap().containsKey(1) || features[1].isEmpty){
      stderr.writeln('Invalid command. Please type appflow --help for available commands.');
      return;
    }

    String feature = features[0];
    List<String> newFolders = features[1].split(',');
    int totalitems = newFolders.length;

    var progress = ProgressBar();
    var i = 0;

    stderr.writeln('Removing $totalitems structure/s...');

    for (var folder in newFolders){
      String path = 'lib/$feature/$folder';
      final dir = Directory(path);

      i++;
      double progresscount = (i / totalitems) * 100;
      progress.update(progresscount.toInt());

      if (await dir.exists()){
        try {
          await dir.delete(recursive: true);
          await _deleteTrackedFile(path);
        } catch (e) {
          stderr.writeln('Error listing directory: $e');
        }
      }
    }
  }

  /// Loads the contents of a Dart file as a string
  /// 
  /// [filePath] : Path to the Dart file (relative or absolute)
  /// Returns file contents as String or null if file not found
  static Future<String?> _loadDartFileAsString(String filePath) async {
    try {
      final file = File(filePath);
      
      // Verify file exists and has .dart extension
      if (await file.exists() && filePath.endsWith('.dart')) {
        return await file.readAsString();
      }
      
      stderr.writeln('File not found or invalid type: $filePath');
      return null;
    } catch (e) {
      stderr.writeln('Error reading file $filePath: $e');
      return null;
    }
  }

  /// Checks if all configured files and folders have been successfully generated.
  ///
  /// Returns `true` if all files and folders exist, otherwise returns `false`.
  static Future<bool> generateOk()async{
    bool filesGenerated = true;
    final externalConfig = await _loadConfig(_defaultConfig);
    final config = externalConfig ?? _parseDefaultConfig();

    final folders = (config['folders'] as List).map((e) => e.toString()).toList();
    final files = Map<String, String>.fromEntries(
      (config['files'] as Map).entries.map((e) => 
        MapEntry(e.key.toString(), e.value.toString()),
    ));

    for (final entry in files.entries){
      String path = entry.key;
      final file = File(path);
      if (! await file.exists()) {
        filesGenerated = false;
        break;
      }
    }

    folders.addAll(AppFlowConstants.additionFolders);
    
    if (filesGenerated){
      for (final folder in folders){
        final dir = Directory(folder);
        if (! await dir.exists()){
          filesGenerated = false;
          break;
        }
      }
    }

    return filesGenerated;
  }

  /// Returns a list of all subdirectories under `lib/{path}` recursively.
  /// Throws an error if the directory does not exist.
  static Future<List<String>> _getLibStructure(String path) async {
    List<String> directories = [];
    String rootDir = 'lib/$path';

    final directory = Directory(rootDir);
    if (! await directory.exists()){
      return Future.error('$path directory does not exist.');
    }

    try {
      await for (var entity in directory.list(recursive: true, followLinks: false)) {
        if (entity is Directory) {
          String dir = entity.path;
          dir = dir.replaceAll('\\', '/');
          directories.add(dir);
        }
      }
    } catch (e) {
      stderr.writeln('Error listing directory: $e');
    }

    return directories;
  }

  /// Extracts the structure of a feature by scanning its folders under `lib/feature/`.
  /// Returns a list of unique subfolder names (excluding root folder).
  static Future<List<String>> _getFeatureStructure(String feature) async {
    List<String> structure = [];
    List<String> directories = await _getLibStructure(feature);

    for (var directory in directories){
      directory = directory.replaceAll('lib/$feature/', '');
      final folders = directory.split('/');

      int index = 0;
      for (var folder in folders){
        if (! structure.contains(folder) && index != 0){
          structure.add(folder);
        }

        index++;
      }
    }
    
    return structure;
  }

  /// Generates metadata header for each generated file including tool version, timestamp, and project name.
  static String _getMetaData() {
    final timestamp = DateTime.now().toIso8601String();
    final buffer = StringBuffer()
      ..writeln('// GENERATED BY APPFLOW')
      ..writeln('// Tool Version: ${AppFlowConstants.version}')
      ..writeln('// Generated At: $timestamp')
      ..writeln('// Project: ${getProjectPubSpecValue('name')}');
      
    return buffer.toString(); 
  }

  /// Adds a generated file or folder to the tracking file with metadata like path, time, tags, and overwrite status.
  static Future<void> _trackGeneratedFile({
    required String path,
    required bool isFile,
    bool overwrite = false,
    List<String> tags = const [],
  }) async {
    final now = DateTime.now().toUtc().toIso8601String();
    final file = File(AppFlowConstants.trackingFileName);
    List<dynamic> entries = [];

    if (await file.exists()) {
      final content = await file.readAsString();
      entries = jsonDecode(content);
    }

    final newEntry = {
      'path': path,
      'created_at': now,
      'tags': tags,
      'overwrite': overwrite,
      'is_file': isFile
    };

    entries.add(newEntry);
    await file.writeAsString(JsonEncoder.withIndent('  ').convert(entries));
  }

  /// Adds or updates an individual entry in the tracking file.
  static Future<void> _updateTrackingFile(Map<String, dynamic> entry) async {
    final file = File(AppFlowConstants.trackingFileName);
    if (await file.exists()) {
      final content = await file.readAsString();
      List<dynamic> entries = jsonDecode(content);
      entries.add(entry);
      await file.writeAsString(JsonEncoder.withIndent('  ').convert(entries));
    }
  }

  /// Deletes a file or folder from the tracking file based on its path.
  static Future<void> _deleteTrackedFile(String path) async{
    final file = File(AppFlowConstants.trackingFileName);
    if (await file.exists()) {
      final content = await file.readAsString();
      List<dynamic> entries = jsonDecode(content);
      entries.removeWhere((entry) => entry['path'] == path || entry['path'].toString().contains(path));
      await file.writeAsString(JsonEncoder.withIndent('  ').convert(entries));
    }
  }

  /// Outputs a summary of all generated items (folders, files, overwrites) from the tracking file.
  static Future<void> status() async {
    final file = File(AppFlowConstants.trackingFileName);
    if (await file.exists()) {
      final content = await file.readAsString();
      List<dynamic> entries = jsonDecode(content);

      int totalFolders = 0;
      int totalFiles = 0;
      int totalOverwrote = 0;
      for (var entry in entries){
        if (entry['is_file']){
          totalFiles++;
          if (entry['overwrite']){
            totalOverwrote++;
          }
        }else{
          totalFolders++;
        }
      }
      
      final buffer = StringBuffer()
        ..writeln('📄 Status Check\n')
        ..writeln('// Project: ${getProjectPubSpecValue('name')} (v${getProjectPubSpecValue('version')})')
        ..writeln('📁 Found $totalFolders generated folders')
        ..writeln('📄 Found $totalFiles generated files')
        ..writeln('📝 $totalOverwrote files overwrote');

      stderr.writeln(buffer.toString());
    }else{
      stderr.writeln('Status check failed. No Tracking file found.');
    }
  }

  /// Main method to generate and update the route file with all screen pages.
  static Future<void> makeRoute(dynamic options)async {
    String? routeFile = options[AppFlowConstants.makeRouteOption] as String;
    List<String> screenPages = await _searchScreenFiles('.');

    routeFile = await _getFullPathToFile(routeFile);
    String? routeContents = await _loadDartFileAsString(routeFile);
    for (var newScreen in screenPages){
      Route route = Route(name: newScreen, content: routeContents!);
      routeContents = route.generate();
      if (routeContents != null){
        final file = File(routeFile);

        await file.create(recursive: true);
        await file.writeAsString(routeContents);
        stderr.writeln('✅ Route file [$routeFile] updated.');
      }
    }

    stderr.writeln('No routes to update.');
  }

  /// Searches for all screen files in the given directory that end with '_screen.dart'
  static Future<List<String>> _searchScreenFiles(String directoryPath) async {
    List<String> screenFiles = [];
    List<dynamic> trakcedFiles = await _getTrackedFiles();
    List<String> trackedScreenFiles = [];

    for (var file in trakcedFiles){
      if (file['path'].endsWith('_screen.dart')){
        trackedScreenFiles.add(file['path']);
      }
    }
    
    final directory = Directory(directoryPath);
    if (!await directory.exists()) {
      return Future.error('Directory does not exist.');
    }

    try {
      await for (var entity in directory.list(recursive: true, followLinks: false)) {
        String file = entity.path
          .replaceAll('.\\', '\\')
          .replaceAll('\\', '/')
          .replaceAll('/lib/', 'lib/');
     
        if (entity is File && entity.path.endsWith('_screen.dart') && !trackedScreenFiles.contains(file)) {
          screenFiles.add(file);
        }
      }
    } catch (e) {
      stderr.writeln('Error: $e');
    }

    return screenFiles;
  }

  /// Returns the full path to a given file by searching recursively
  static Future<String> _getFullPathToFile(String file) async {
    String fullPath = '';

    final directory = Directory('.');
    if (!await directory.exists()) {
      return Future.error('Directory does not exist.');
    }

    try {
      await for (var entity in directory.list(recursive: true, followLinks: false)) {
        if (entity is File && entity.path.contains(file)) {
          fullPath = entity.path
            .replaceAll('.\\', '\\')
            .replaceAll('\\', '/')
            .replaceAll('/lib/', 'lib/');
          break;
        }
      }
    } catch (e) {
      stderr.writeln('Error: $e');
    }

    return fullPath;
  }

  /// Loads and parses a tracking file which keeps a record of known screen files
  static Future<List<dynamic>> _getTrackedFiles() async{
    final file = File(AppFlowConstants.trackingFileName);
    List<dynamic> entries = [];

    if (await file.exists()) {
      final content = await file.readAsString();
      entries = jsonDecode(content);
    }else{
      return Future.error('Error: Tracking file is missing');
    }

    return entries;
  }

}