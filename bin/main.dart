// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:yaml/yaml.dart';

// 🌎 Project imports:
import 'package:import_sorter/files.dart' as files;
import 'package:import_sorter/sort.dart' as sort;

void main(List<String> args) {
  final currentPath = Directory.current.path;
  /*
  Getting the package name and dependencies/dev_dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev_dependencies names are used to identify package imports
  */
  final pubspecYamlFile = File('${currentPath}/pubspec.yaml');
  final pubspecYaml = loadYaml(pubspecYamlFile.readAsStringSync());

  // Getting all dependencies and package name
  final packageName = pubspecYaml['name'];
  final dependencies = [];
  if (pubspecYaml.containsKey('dependencies')) {
    if (pubspecYaml['dependencies'].keys.contains('flutter')) {
      print('┏━━🏃‍ Running: flutter pub get');
      Process.runSync('flutter', ['pub', 'get'], runInShell: true);
      print('┃  ┗━━✅ Ran flutter pub get\n┃  ');
    } else {
      print('┏━━🏃‍ Running: pub get');
      Process.runSync('pub', ['get'], runInShell: true);
      print('┃  ┗━━✅ Ran pub get\n┃  ');
    }
  }

  final stopwatch = Stopwatch();
  stopwatch.start();

  final pubspecLockFile = File('${currentPath}/pubspec.lock');
  final pubspecLock = loadYaml(pubspecLockFile.readAsStringSync());
  dependencies.addAll(pubspecLock['packages'].keys);

  var emojis = false;
  final ignored_files = [];

  // Reading from config in pubspec.yaml
  if (!args.contains('--ignore-config')) {
    if (pubspecYaml.containsKey('import_sorter')) {
      final config = pubspecYaml['import_sorter'];
      if (config.containsKey('emojis')) emojis = config['emojis'];
      if (config.containsKey('ignored_files')) {
        ignored_files.addAll(config['ignored_files']);
      }
    }
  }

  // Setting values from args
  if (!emojis) emojis = args.contains('-e');

  // Getting all the dart files for the project
  final dartFiles = files.dartFiles(currentPath);
  if (dependencies.contains('flutter') &&
      dartFiles
          .containsKey('${currentPath}/lib/generated_plugin_registrant.dart')) {
    dartFiles.remove('${currentPath}/lib/generated_plugin_registrant.dart');
  }
  for (final file in ignored_files) {
    dartFiles.remove('$currentPath$file');
  }

  print('┣━━🏭 Sorting Files');

  // Sorting and writing to files
  int filesFormatted = 0;
  for (final String filePath in dartFiles.keys) {
    File(filePath).writeAsStringSync(sort.sortImports(
      dartFiles[filePath],
      packageName,
      dependencies,
      emojis,
    ));
    filesFormatted++;
    print(
        '┃  ${filesFormatted == dartFiles.keys.length ? '┗' : '┣'}━━✅ Formatted ${filePath.replaceAll(currentPath, '')}');
  }
  stopwatch.stop();
  print(
      '┃  \n┗━━😄 Formatted $filesFormatted files in ${stopwatch.elapsed.inSeconds}.${stopwatch.elapsedMilliseconds} seconds');
}
