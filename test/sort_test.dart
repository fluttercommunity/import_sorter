// 📦 Package imports:
import 'package:test/test.dart';

// 🌎 Project imports:
import 'package:import_sorter/sort.dart';

void switcher(bool emojis, bool noComments) {
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
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/physics.dart';
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

  final dartImportComment =
      noComments ? '' : '// ${emojis ? '🎯 ' : ''}Dart imports:\n';
  final flutterImportComment =
      noComments ? '' : '// ${emojis ? '🐦 ' : ''}Flutter imports:\n';
  final packageImportComment =
      noComments ? '' : '// ${emojis ? '📦 ' : ''}Package imports:\n';
  final projectImportComment =
      noComments ? '' : '// ${emojis ? '🌎 ' : ''}Project imports:\n';

  test(
    'No imports and no code',
    () {
      expect(
        sortImports(
          [],
          packageName,
          dependencies,
          emojis,
          false,
          noComments,
        )[0],
        '',
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
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        '$dartImportComment$dartImports\n$flutterImportComment$flutterImports\n$packageImportComment$packageImports\n$projectImportComment$projectImports\n',
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
        false,
        noComments,
      );
      expect('${sortedImports[0]}\n', '$sampleProgram\n');
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
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        '$dartImportComment$dartImports\n$sampleProgram\n',
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
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        '$flutterImportComment$flutterImports\n$sampleProgram\n',
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
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        '$packageImportComment$packageImports\n$sampleProgram\n',
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
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        '$projectImportComment$projectImports\n$sampleProgram\n',
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
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        '$dartImportComment$dartImports\n$flutterImportComment$flutterImports\n$packageImportComment$packageImports\n$projectImportComment$projectImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Code before all imports',
    () {
      final sortedImports = sortImports(
        'library import_sorter;\n$projectImports\n$packageImports\n$dartImports\n$flutterImports\n$sampleProgram'
            .split('\n'),
        packageName,
        dependencies,
        emojis,
        false,
        noComments,
      );
      expect(
        sortedImports[0],
        'library import_sorter;\n\n$dartImportComment$dartImports\n$flutterImportComment$flutterImports\n$packageImportComment$packageImports\n$projectImportComment$projectImports\n$sampleProgram\n',
      );
    },
  );
}

void main() {
  group(
    'No Emojis and Comments',
    () => switcher(false, false),
  );
  group(
    'Emojis and Comments',
    () => switcher(true, false),
  );
  group(
    'No Emojis and No Comments',
    () => switcher(false, true),
  );
  group(
    'Emojis and No Comments',
    () => switcher(true, true),
  );
}
