// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:colorize/colorize.dart';

/// Sort the imports
/// Returns the sorted file as a string at
/// index 0 and the number of sorted imports
/// at index 1
List sortImports(
  List<String> lines,
  String package_name,
  List dependencies,
  bool emojis,
  bool exitIfChanged,
  bool noComments,
) {
  String dartImportComment(bool emojis) =>
      '//${emojis ? ' 🎯 ' : ' '}Dart imports:';
  String flutterImportComment(bool emojis) =>
      '//${emojis ? ' 🐦 ' : ' '}Flutter imports:';
  String packageImportComment(bool emojis) =>
      '//${emojis ? ' 📦 ' : ' '}Package imports:';
  String projectImportComment(bool emojis) =>
      '//${emojis ? ' 🌎 ' : ' '}Project imports:';

  final beforeImportLines = <String>[];
  final afterImportLines = <String>[];

  final dartImports = <String>[];
  final flutterImports = <String>[];
  final packageImports = <String>[];
  final projectImports = <String>[];

  bool noImports() =>
      dartImports.isEmpty &&
      flutterImports.isEmpty &&
      packageImports.isEmpty &&
      projectImports.isEmpty;

  var isMultiLineString = false;

  for (var i = 0; i < lines.length; i++) {
    // Check if line is in multiline string
    if (_timesContained(lines[i], "'''") == 1 ||
        _timesContained(lines[i], '"""') == 1) {
      isMultiLineString = !isMultiLineString;
    }

    // If line is an import line
    if (lines[i].startsWith('import ') &&
        lines[i].endsWith(';') &&
        !isMultiLineString) {
      if (lines[i].contains('dart:')) {
        dartImports.add(lines[i]);
      } else if (lines[i].contains('package:flutter/')) {
        flutterImports.add(lines[i]);
      } else if (lines[i].contains('package:$package_name/') ||
          !lines[i].contains('package:')) {
        projectImports.add(lines[i]);
      }
      for (final dependency in dependencies) {
        if (lines[i].contains('package:$dependency/') &&
            dependency != 'flutter') {
          packageImports.add(lines[i]);
        }
      }
    } else if (i != lines.length - 1 &&
        (lines[i] == dartImportComment(false) ||
            lines[i] == flutterImportComment(false) ||
            lines[i] == packageImportComment(false) ||
            lines[i] == projectImportComment(false) ||
            lines[i] == dartImportComment(true) ||
            lines[i] == flutterImportComment(true) ||
            lines[i] == packageImportComment(true) ||
            lines[i] == projectImportComment(true) ||
            lines[i] == '// 📱 Flutter imports:') &&
        lines[i + 1].startsWith('import ') &&
        lines[i + 1].endsWith(';')) {
    } else if (noImports()) {
      beforeImportLines.add(lines[i]);
    } else {
      afterImportLines.add(lines[i]);
    }
  }

  // If no import return original string of lines
  if (noImports()) {
    if (lines.length > 1) {
      if (lines.last != '') {
        return [
          [...lines, ''].join('\n'),
          0
        ];
      }
    }
    return [lines.join('\n'), 0];
  }

  // Remove spaces
  if (beforeImportLines.isNotEmpty) {
    if (beforeImportLines.last.trim() == '') {
      beforeImportLines.removeLast();
    }
  }

  final sortedLines = <String>[...beforeImportLines];

  // Adding content conditionally
  if (beforeImportLines.isNotEmpty) {
    sortedLines.add('');
  }
  if (dartImports.isNotEmpty) {
    if (!noComments) sortedLines.add(dartImportComment(emojis));
    dartImports.sort();
    sortedLines.addAll(dartImports);
  }
  if (flutterImports.isNotEmpty) {
    if (dartImports.isNotEmpty) sortedLines.add('');
    if (!noComments) sortedLines.add(flutterImportComment(emojis));
    flutterImports.sort();
    sortedLines.addAll(flutterImports);
  }
  if (packageImports.isNotEmpty) {
    if (dartImports.isNotEmpty || flutterImports.isNotEmpty) {
      sortedLines.add('');
    }
    if (!noComments) sortedLines.add(packageImportComment(emojis));
    packageImports.sort();
    sortedLines.addAll(packageImports);
  }
  if (projectImports.isNotEmpty) {
    if (dartImports.isNotEmpty ||
        flutterImports.isNotEmpty ||
        packageImports.isNotEmpty) {
      sortedLines.add('');
    }
    if (!noComments) sortedLines.add(projectImportComment(emojis));
    projectImports.sort();
    sortedLines.addAll(projectImports);
  }

  sortedLines.add('');

  var addedCode = false;
  for (var j = 0; j < afterImportLines.length; j++) {
    if (afterImportLines[j] != '') {
      sortedLines.add(afterImportLines[j]);
      addedCode = true;
    }
    if (addedCode && afterImportLines[j] == '') {
      sortedLines.add(afterImportLines[j]);
    }
  }
  sortedLines.add('');

  final sortedFile = sortedLines.join('\n');
  if (exitIfChanged && lines.join('\n') + '\n' != sortedFile) {
    stdout.write('\n┗━━🚨 ');
    color(
      'Please run import sorter!',
      back: Styles.BOLD,
      front: Styles.RED,
      isBold: true,
    );
    exit(1);
  }

  return [
    sortedFile,
    dartImports.length +
        flutterImports.length +
        packageImports.length +
        projectImports.length
  ];
}

/// Get the number of times a string contains another
/// string
int _timesContained(String string, String looking) =>
    string.split(looking).length - 1;
