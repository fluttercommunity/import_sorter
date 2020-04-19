/// Sort the imports
String sortImports(
  List<String> lines,
  String package_name,
  List<String> dependencies,
) {
  final beforeImportLines = <String>[];
  final afterImportLines = <String>[];

  final dartImports = <String>[];
  final flutterImports = <String>[];
  final packageImports = <String>[];
  final projectImports = <String>[];

  for (final line in lines) {
    // If line is an import line
    if (line.startsWith('import ') && line.endsWith('.dart;')) {
      if (line.contains('dart:')) {
        dartImports.add(line);
      } else if (line.contains('package:flutter/')) {
        flutterImports.add(line);
      } else if (line.contains('package:$package_name') ||
          !line.contains('package:')) {
        projectImports.add(line);
      }
      for (final dependency in dependencies) {
        if (line.contains('package:$dependency')) {
          packageImports.add(line);
        }
      }
    } else if (beforeImportLines.isEmpty) {
      beforeImportLines.add(line);
    } else {
      afterImportLines.add(line);
    }
  }
  return [
    ...beforeImportLines,
    '',
    dartImports.isNotEmpty ? '// Dart imports:' : '',
    ...dartImports,
    flutterImports.isNotEmpty ? '// Flutter imports:' : '',
    ...flutterImports,
    packageImports.isNotEmpty ? '// Package imports:' : '',
    ...packageImports,
    projectImports.isNotEmpty ? '// Project imports:' : '',
    ...projectImports,
    '',
    ...afterImportLines,
  ].join('\n');
}
