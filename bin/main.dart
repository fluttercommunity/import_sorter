// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:args/args.dart';
import 'package:tint/tint.dart';
import 'package:yaml/yaml.dart';

// 🌎 Project imports:
import 'package:import_sorter/args.dart' as local_args;
import 'package:import_sorter/files.dart' as files;
import 'package:import_sorter/sort.dart' as sort;

void main(List<String> args) {
  // Parsing arguments
  final parser = ArgParser();
  parser.addFlag('emojis', abbr: 'e', negatable: false);
  parser.addFlag('ignore-config', negatable: false);
  parser.addFlag('help', abbr: 'h', negatable: false);
  parser.addFlag('exit-if-changed', negatable: false);
  parser.addFlag('no-comments', negatable: false);
  final argResults = parser.parse(args).arguments;
  if (argResults.contains('-h') || argResults.contains('--help')) {
    local_args.outputHelp();
  }

  final currentPath = Directory.current.path;
  /*
  Getting the package name and dependencies/dev_dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev_dependencies names are used to identify package imports
  */
  final pubspecYamlFile = File('${currentPath}/pubspec.yaml');
  final pubspecYaml = loadYaml(pubspecYamlFile.readAsStringSync());

  // Getting all dependencies and project package name
  final packageName = pubspecYaml['name'];
  final dependencies = [];

  final stopwatch = Stopwatch();
  stopwatch.start();

  final pubspecLockFile = File('${currentPath}/pubspec.lock');
  final pubspecLock = loadYaml(pubspecLockFile.readAsStringSync());
  dependencies.addAll(pubspecLock['packages'].keys);

  var emojis = false;
  var noComments = false;
  final ignored_files = [];

  // Reading from config in pubspec.yaml safely
  if (!argResults.contains('--ignore-config')) {
    if (pubspecYaml.containsKey('import_sorter')) {
      final config = pubspecYaml['import_sorter'];
      if (config.containsKey('emojis')) emojis = config['emojis'];
      if (config.containsKey('comments')) noComments = !config['comments'];
      if (config.containsKey('ignored_files')) {
        ignored_files.addAll(config['ignored_files']);
      }
    }
  }

  // Setting values from args
  if (!emojis) emojis = argResults.contains('-e');
  if (!noComments) noComments = argResults.contains('--no-comments');
  final exitOnChange = argResults.contains('--exit-if-changed');

  // Getting all the dart files for the project
  final dartFiles = files.dartFiles(currentPath, args);
  if (dependencies.contains('flutter/') &&
      dartFiles
          .containsKey('${currentPath}/lib/generated_plugin_registrant.dart')) {
    dartFiles.remove('${currentPath}/lib/generated_plugin_registrant.dart');
  }
  for (final pattern in ignored_files) {
    dartFiles.removeWhere((key, _) =>
        RegExp(pattern).hasMatch(key.replaceFirst(currentPath, '')));
  }

  stdout.write('┏━━ Sorting ${dartFiles.length} dart files');

  // Sorting and writing to files
  final sortedFiles = [];
  final success = '✔'.green();

  for (final filePath in dartFiles.keys) {
    final file = dartFiles[filePath];
    if (file == null) {
      continue;
    }

    final sortedFile = sort.sortImports(
        file.readAsLinesSync(), packageName, emojis, exitOnChange, noComments);
    if (!sortedFile.updated) {
      continue;
    }
    dartFiles[filePath]?.writeAsStringSync(sortedFile.sortedFile);
    sortedFiles.add(filePath);
  }

  stopwatch.stop();

  // Outputting results
  if (sortedFiles.length > 1) {
    stdout.write("\n");
  }
  for (int i = 0; i < sortedFiles.length; i++) {
    final file = dartFiles[sortedFiles[i]];
    stdout.write(
        '${sortedFiles.length == 1 ? '\n' : ''}┃  ${i == sortedFiles.length - 1 ? '┗' : '┣'}━━ ${success} Sorted imports for ${file?.path.replaceFirst(currentPath, '')}/');
    String filename = file!.path.split(Platform.pathSeparator).last;
    stdout.write(filename + "\n");
  }


  if (sortedFiles.length == 0) {
    stdout.write("\n");
  }
  stdout.write(
      '┗━━ ${success} Sorted ${sortedFiles.length} files in ${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} seconds\n');
}
