// 📦 Package imports:
import 'package:test/test.dart';

// 🌎 Project imports:
import 'package:import_sorter/sort.dart';

void emojiSwitcher(bool emojis) {
  const packageName = 'import_sorter_test';
  const dependencies = [
    'provider',
    'mdi',
    'intl',
    'yaml',
    'flutter',
  ];

  // Imports:
  const dartImports = '''
import 'dart:async';
import 'dart:io';
import 'dart:js';
''';
  const flutterImports = '''
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/painting.dart';
''';
  const packageImports = '''
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
''';
  const projectImports = '''
import 'anotherFile.dart' as af;
import 'package:import_sorter_test/anotherFile2.dart';
''';

  const sampleProgram = '''
void main(List<String> args) async {
  final stopwatch = Stopwatch();
  stopwatch.start();

  final currentPath = Directory.current.path;
  /*
  Getting the package name and dependencies/dev_dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev_dependencies names are used to identify package imports
  */
  final pubspecYamlFile = File('\${currentPath}/pubspec.yaml');
  final pubspecYaml = loadYaml(pubspecYamlFile.readAsStringSync());
}
''';

  test(
    'No imports and code',
    () {
      expect(
        sortImports(
          [],
          packageName,
          dependencies,
          emojis,
        ),
        '\n',
      );
    },
  );
  test(
    'No code, only imports',
    () {
      final sortedImports = sortImports(
        '$projectImports\n$packageImports\n$dartImports\n$flutterImports\n'
            .split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(
        sortedImports,
        '// ${emojis ? '🎯 ' : ''}Dart imports:\n$dartImports\n// ${emojis ? '📱 ' : ''}Flutter imports:\n$flutterImports\n// ${emojis ? '📦 ' : ''}Package imports:\n$packageImports\n// ${emojis ? '🌎 ' : ''}Project imports:\n$projectImports\n',
      );
    },
  );
  test(
    'No imports',
    () {
      final sortedImports = sortImports(
        sampleProgram.split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(sortedImports, '$sampleProgram\n');
    },
  );
  test(
    'Dart Imports',
    () {
      final sortedImports = sortImports(
        '$dartImports\n$sampleProgram'.split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(
        sortedImports,
        '// ${emojis ? '🎯 ' : ''}Dart imports:\n$dartImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Flutter Imports',
    () {
      final sortedImports = sortImports(
        '$flutterImports\n$sampleProgram'.split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(
        sortedImports,
        '// ${emojis ? '📱 ' : ''}Flutter imports:\n$flutterImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Package Imports',
    () {
      final sortedImports = sortImports(
        '$packageImports\n$sampleProgram'.split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(
        sortedImports,
        '// ${emojis ? '📦 ' : ''}Package imports:\n$packageImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Project Imports',
    () {
      final sortedImports = sortImports(
        '$projectImports\n$sampleProgram'.split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(
        sortedImports,
        '// ${emojis ? '🌎 ' : ''}Project imports:\n$projectImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'All Imports',
    () {
      final sortedImports = sortImports(
        '$projectImports\n$packageImports\n$dartImports\n$flutterImports\n$sampleProgram'
            .split('\n'),
        packageName,
        dependencies,
        emojis,
      );
      expect(
        sortedImports,
        '// ${emojis ? '🎯 ' : ''}Dart imports:\n$dartImports\n// ${emojis ? '📱 ' : ''}Flutter imports:\n$flutterImports\n// ${emojis ? '📦 ' : ''}Package imports:\n$packageImports\n// ${emojis ? '🌎 ' : ''}Project imports:\n$projectImports\n$sampleProgram\n',
      );
    },
  );
}

void main() {
  group(
    'No Emojis',
    () {
      emojiSwitcher(false);
    },
  );
  group(
    'Emojis',
    () {
      emojiSwitcher(true);
    },
  );
}
