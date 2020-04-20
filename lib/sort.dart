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

  for (int i = 0; i < lines.length; i++) {
    // If line is an import line
    if (lines[i].startsWith('import ') && lines[i].endsWith(';')) {
      if (lines[i].contains('dart:')) {
        dartImports.add(lines[i]);
      } else if (lines[i].contains('package:flutter/')) {
        flutterImports.add(lines[i]);
      } else if (lines[i].contains('package:$package_name') ||
          !lines[i].contains('package:')) {
        projectImports.add(lines[i]);
      }
      for (final dependency in dependencies) {
        if (lines[i].contains('package:$dependency')) {
          packageImports.add(lines[i]);
        }
      }
    } else if (i != lines.length &&
        lines[i].contains('//') &&
        (lines[i + 1].startsWith('import ') && lines[i + 1].endsWith(';'))) {
    } else if (dartImports.isEmpty &&
        flutterImports.isEmpty &&
        packageImports.isEmpty &&
        projectImports.isEmpty) {
      beforeImportLines.add(lines[i]);
    } else {
      afterImportLines.add(lines[i]);
    }
  }

  final sortedLines = <String>[...beforeImportLines];
  final imports = [
    dartImports.isNotEmpty,
    flutterImports.isNotEmpty,
    packageImports.isNotEmpty,
    projectImports.isNotEmpty,
  ];

  // Adding content conditionally
  if (beforeImportLines.isNotEmpty) {
    sortedLines.add('');
  }
  if (dartImports.isNotEmpty) {
    sortedLines.add('// Dart imports:');
    sortedLines.addAll(dartImports);
  }
  if (flutterImports.isNotEmpty) {
    sortedLines.add('\n// Flutter imports');
    sortedLines.addAll(flutterImports);
  }
  if (packageImports.isNotEmpty) {
    sortedLines.add('\n// Package imports:');
    sortedLines.addAll(packageImports);
  }
  if (projectImports.isNotEmpty) {
    sortedLines.add('\n// Project imports:');
    sortedLines.addAll(projectImports);
  }

  var foundCode = false;
  for (int j = 0; j < afterImportLines.length; j++) {
    if (afterImportLines[j] != '') {
      foundCode = true;
    }
    if (!foundCode && afterImportLines[j] == '') {
      afterImportLines.removeAt(j);
    }
  }

  sortedLines.add('');
  sortedLines.addAll(afterImportLines);

  return sortedLines.join('\n');
}

