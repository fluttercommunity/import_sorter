// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:args/args.dart';
import 'package:colorize/colorize.dart';
import 'package:yaml/yaml.dart';

// 🌎 Project imports:
import 'package:import_sorter/args.dart' as local_args;
import 'package:import_sorter/files.dart' as files;
import 'package:import_sorter/sort.dart' as sort;

void main(List<String> args) {
  // Setting arguments
  final parser = ArgParser();
  parser.addFlag(
    'emojis',
    abbr: 'e',
    negatable: false,
  );
  parser.addFlag(
    'ignore-config',
    negatable: false,
  );
  parser.addFlag(
    'help',
    abbr: 'h',
    negatable: false,
  );
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
  final ignored_files = [];

  // Reading from config in pubspec.yaml safely
  if (!argResults.contains('--ignore-config')) {
    if (pubspecYaml.containsKey('import_sorter')) {
      final config = pubspecYaml['import_sorter'];
      if (config.containsKey('emojis')) emojis = config['emojis'];
      if (config.containsKey('ignored_files')) {
        ignored_files.addAll(config['ignored_files']);
      }
    }
  }

  // Setting values from args
  if (!emojis) emojis = argResults.contains('-e');

  // Getting all the dart files for the project
  final dartFiles = files.dartFiles(currentPath);
  if (dependencies.contains('flutter') &&
      dartFiles
          .containsKey('${currentPath}/lib/generated_plugin_registrant.dart')) {
    dartFiles.remove('${currentPath}/lib/generated_plugin_registrant.dart');
  }
  for (final pattern in ignored_files) {
    final expression = RegExp(
      pattern,
      multiLine: false,
    );
    dartFiles.removeWhere((key, _) => expression.hasMatch(key));
  }

  stdout.write('\n┏━━🏭 Sorting Files');

  // Sorting and writing to files
  int filesFormatted = 0;
  int importsSorted = 0;

  for (final String filePath in dartFiles.keys) {
    final sortedFile = sort.sortImports(
        dartFiles[filePath], packageName, dependencies, emojis);
    File(filePath).writeAsStringSync(sortedFile[0]);
    importsSorted += sortedFile[1];
    filesFormatted++;
    final dirChunks = filePath.replaceAll(currentPath, '').split('/');
    stdout.write(
        '${filesFormatted == 1 ? '\n' : ''}┃  ${filesFormatted == dartFiles.keys.length ? '┗' : '┣'}━━✅ Sorted ${sortedFile[1]} imports in ${dirChunks.getRange(0, dirChunks.length - 1).join('/')}/');
    color(
      dirChunks.last,
      back: Styles.BOLD,
      front: Styles.GREEN,
      isBold: true,
    );
  }
  stopwatch.stop();
  stdout.write(
      '┃\n┗━━🙌 Sorted $importsSorted imports in ${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} seconds\n');
  stdout.write('\n');
}
