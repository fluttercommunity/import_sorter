// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:yaml/yaml.dart';
import 'package:process_run/process_run.dart';

// 🌎 Project imports:
import 'package:import_sorter/files.dart' as files;
import 'package:import_sorter/sort.dart' as sort;

void main(List<String> args) async {
  /*
  Getting the package name and dependencies/dev_dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev_dependency names are used to identify package imports
  */
  final pubspecYamlFile = File('${Directory.current.path}/pubspec.yaml');
  final pubspecYaml = loadYaml(pubspecYamlFile.readAsStringSync());

  // Getting all dependencies and package name
  final packageName = pubspecYaml['name'];
  final dependencies = [];
  if (pubspecYaml.containsKey('dependencies')) {
    if (pubspecYaml['dependencies'].keys.contains('flutter')) {
      print('🏃‍♂️ Running: flutter pub get');
      await run('flutter', ['pub', 'get']);
      print('\t✅ Ran flutter pub get\n');
    } else {
      print('🏃‍♂️ Running: pub get');
      await run('pub', ['get']);
      print('\t✅ Ran pub get\n');
    }
  }
  final pubspecLockFile = File('${Directory.current.path}/pubspec.lock');
  final pubspecLock = loadYaml(pubspecLockFile.readAsStringSync());
  dependencies.addAll(pubspecLock['packages'].keys);

  var emojis = false;
  final ignored_files = [];

  // Reading from config in pubspec.yaml
  if (!args.contains('--ignore-config')) {
    if (pubspecYaml.containsKey('import_sorter')) {
      final config = pubspecYaml['import_sorter'];
      if (config.containsKey('emojis')) emojis = config['emojis'];
      if (config.containsKey('ignored_files'))
        ignored_files.addAll(config['ignored_files']);
    }
  }

  // Setting values from args
  if (!emojis) emojis = args.contains('-e');

  // Getting all the dart files for the project
  final dartFiles = files.dartFiles();
  final currentPath = Directory.current.path;
  if (dependencies.contains('flutter') &&
      dartFiles.containsKey(
          '${Directory.current.path}/lib/generated_plugin_registrant.dart'))
    dartFiles.remove(
        '${Directory.current.path}/lib/generated_plugin_registrant.dart');
  for (final file in ignored_files) {
    dartFiles.remove('$currentPath$file');
  }

  // Sorting and writing to files
  for (final filePath in dartFiles.keys) {
    File(filePath).writeAsStringSync(sort.sortImports(
      dartFiles[filePath],
      packageName,
      dependencies,
      emojis,
    ));
    print('✅ Formatted ${filePath.replaceAll(Directory.current.path, '')}');
  }
}
