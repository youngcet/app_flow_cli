import 'dart:io';

import 'package:app_flow_cli/src/utils.dart';
import 'package:path/path.dart';

class Route {
  final String name;
  final String content;
  
  Route({
    required this.name,
    required this.content
  });

  String? generate(){
    String? newContent = _add();
    if (newContent != null){
      newContent = _import(newContent);
      newContent = _constants(newContent);
    }

    return newContent!;
  }

  String? _add(){
    String? newContent;
    
    final appflowRouteInjection = RegExp(r'\/\/ <appflow-start:route>(.|\n)*?\/\/ <appflow-end:route>');
    final match = appflowRouteInjection.firstMatch(content);
    if (match != null) {
      String? routeInjection = match.group(0);
      File file = File(name);
      String screen = basename(file.path);
      List<String> fileParts = screen.split('_');
      String widgetName = '${capitalize(fileParts[0])}${capitalize(fileParts[1])}';
      widgetName = widgetName.replaceAll('.dart', '()');
      
      routeInjection = routeInjection!
        .replaceAll('// <appflow-start:route>', '')
        .replaceAll('// <appflow-end:route>', '')
        .replaceAll('<appflow-screen>', screen.replaceAll('_screen.dart', '').toLowerCase())
        .replaceAll('<appflow-screen:callback>', widgetName)
        .replaceAll('//', '').trim();
      
      newContent = content.replaceAll('${match.group(0)}', '$routeInjection\n${match.group(0)}');
    }

    return newContent;
  }

  String _import(String str){
    String importFile = name.replaceAll('lib/', '');
    String newContent = str.replaceAll('// <appflow-imports>', "import 'package:${getProjectPubSpecValue('name')}/$importFile';\n// <appflow-imports>");
    return newContent;
  } 

  String _constants(String str){
    File file = File(name);
    String screen = basename(file.path).replaceAll('_screen.dart', '').toLowerCase();

    return str.replaceAll('// <appflow-constants>', "static const String $screen = '/$screen';\n// <appflow-constants>");
  } 

  String _widgetName(){
    File file = File(name);
    String screen = basename(file.path);
    List<String> fileParts = screen.split('_');
    String widgetName = '${capitalize(fileParts[0])}${capitalize(fileParts[1])}';
    widgetName = widgetName.replaceAll('.dart', '()');

    return widgetName;
  }
}