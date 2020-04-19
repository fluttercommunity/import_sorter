/// Sort the imports

String sortImports(
  List<String> lines,
  String package_name,
  List dependencies,
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

  final sortedLines = <String>[...beforeImportLines];
  final imports = dartImports.isNotEmpty &&
      flutterImports.isNotEmpty &&
      packageImports.isNotEmpty &&
      projectImports.isNotEmpty;

  // Adding content conditionally
  if (imports) {
    sortedLines.add('');
  }
  if (dartImports.isNotEmpty) {
    sortedLines.add('// Dart imports:');
    sortedLines.addAll(dartImports);
  }
  if (flutterImports.isNotEmpty) {
    sortedLines.add('// Flutter imports');
    sortedLines.addAll(flutterImports);
  }
  if (packageImports.isNotEmpty) {
    sortedLines.add('// Package imports:');
    sortedLines.addAll(packageImports);
  }
  if (afterImportLines.isNotEmpty) {
    sortedLines.add('// Project imports:');
    sortedLines.addAll(projectImports);
  }
  if (imports) {
    sortedLines.add('');
  }
  sortedLines.addAll(afterImportLines);

  return sortedLines.join('\n');
}
