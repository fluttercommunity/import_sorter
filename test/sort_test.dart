// 📦 Package imports:
import 'package:test/test.dart';

// 🌎 Project imports:
import 'package:import_sorter/sort.dart';

void switcher(bool emojis, bool noComments) {
  const packageName = 'import_sorter_test';

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
import 'package:flutter_gen/gen_l10n/translations.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
''';
  const projectImports = '''
import 'package:import_sorter_test/anotherFile2.dart';
import 'anotherFile.dart' as af;
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
}''';

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
          emojis,
          false,
          noComments,
        ).sortedFile,
        '\n',
      );
    },
  );
  test(
    'Single code line',
    () {
      expect(
        sortImports(
          ['enum HomeEvent { showInfo, showDiscover, showProfile }', ''],
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        'enum HomeEvent { showInfo, showDiscover, showProfile }\n\n',
      );
    },
  );
  test(
    'No code, only imports',
    () {
      expect(
        sortImports(
          '$projectImports\n$packageImports\n$dartImports\n$flutterImports\n'
              .split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        '$dartImportComment$dartImports\n$flutterImportComment$flutterImports\n$packageImportComment$packageImports\n$projectImportComment$projectImports\n',
      );
    },
  );
  test(
    'No imports',
    () {
      expect(
          sortImports(
            sampleProgram.split('\n'),
            packageName,
            emojis,
            false,
            noComments,
          ).sortedFile,
          '$sampleProgram\n');
    },
  );
  test(
    'Dart Imports',
    () {
      expect(
        sortImports(
          '$dartImports\n$sampleProgram'.split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        '$dartImportComment$dartImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Flutter Imports',
    () {
      expect(
        sortImports(
          '$flutterImports\n$sampleProgram'.split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        '$flutterImportComment$flutterImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Package Imports',
    () {
      expect(
        sortImports(
          '$packageImports\n$sampleProgram'.split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        '$packageImportComment$packageImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Project Imports',
    () {
      expect(
        sortImports(
          '$projectImports\n$sampleProgram'.split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        '$projectImportComment$projectImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'All Imports',
    () {
      expect(
        sortImports(
          '$projectImports\n$packageImports\n$dartImports\n$flutterImports\n$sampleProgram'
              .split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
        '$dartImportComment$dartImports\n$flutterImportComment$flutterImports\n$packageImportComment$packageImports\n$projectImportComment$projectImports\n$sampleProgram\n',
      );
    },
  );
  test(
    'Code before all imports',
    () {
      expect(
        sortImports(
          'library import_sorter;\n$projectImports\n$packageImports\n$dartImports\n$flutterImports\n$sampleProgram'
              .split('\n'),
          packageName,
          emojis,
          false,
          noComments,
        ).sortedFile,
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
