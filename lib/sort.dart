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
        if (lines[i].contains('package:$dependency') &&
            dependency != 'flutter') {
          packageImports.add(lines[i]);
        }
      }
    } else if (i != lines.length &&
        lines[i].contains('//') &&
        lines[i + 1].startsWith('import ') &&
        lines[i + 1].endsWith(';')) {
    } else if (dartImports.isEmpty &&
        flutterImports.isEmpty &&
        packageImports.isEmpty &&
        projectImports.isEmpty) {
      beforeImportLines.add(lines[i]);
    } else {
      afterImportLines.add(lines[i]);
    }
  }

  if (dartImports.isEmpty &&
      flutterImports.isEmpty &&
      packageImports.isEmpty &&
      projectImports.isEmpty) {
    return beforeImportLines.join('\n') + '\n';
  }

  beforeImportLines.removeWhere((line) => line != '');

  final sortedLines = <String>[...beforeImportLines];

  // Adding content conditionally
  if (beforeImportLines.isNotEmpty) {
    sortedLines.add('');
  }
  if (dartImports.isNotEmpty) {
    sortedLines.add('// Dart imports:');
    sortedLines.addAll(dartImports);
  }
  if (flutterImports.isNotEmpty) {
    if (dartImports.isNotEmpty) {
      sortedLines.add('');
    }
    sortedLines.add('// Flutter imports:');
    sortedLines.addAll(flutterImports);
  }
  if (packageImports.isNotEmpty) {
    if (flutterImports.isNotEmpty ||
        (flutterImports.isEmpty && dartImports.isNotEmpty)) {
      sortedLines.add('');
    }
    sortedLines.add('// Package imports:');
    sortedLines.addAll(packageImports);
  }
  if (projectImports.isNotEmpty) {
    if (packageImports.isNotEmpty ||
        ((packageImports.isEmpty && flutterImports.isEmpty) &&
            dartImports.isNotEmpty) ||
        ((dartImports.isEmpty && packageImports.isEmpty) &&
            flutterImports.isNotEmpty)) {
      sortedLines.add('');
    }
    sortedLines.add('// Project imports:');
    sortedLines.addAll(projectImports);
  }

  sortedLines.add('');

  var addedCode = false;
  for (int j = 0; j < afterImportLines.length; j++) {
    if (afterImportLines[j] != '') {
      sortedLines.add(afterImportLines[j]);
      addedCode = true;
    }
    if (addedCode && afterImportLines[j] == '') {
      sortedLines.add(afterImportLines[j]);
    }
  }

  sortedLines.add('');

  return sortedLines.join('\n');
}