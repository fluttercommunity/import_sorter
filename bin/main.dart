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
  Getting the package name and dependencies/dev-dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev-dependency names are used to identify package imports
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
      print('\t✅ Ran flutter pub get\n');
    }
  }
  final pubspecLockFile = File('${Directory.current.path}/pubspec.lock');
  final pubspecLock = loadYaml(pubspecLockFile.readAsStringSync());
  dependencies.addAll(pubspecLock['packages'].keys);

  // Getting all the dart files for the project
  final dartFiles = files.dartFiles();
  if (dependencies.contains('flutter') &&
      dartFiles.containsKey(
          '${Directory.current.path}/lib/generated_plugin_registrant.dart')) {
    dartFiles.remove(
        '${Directory.current.path}/lib/generated_plugin_registrant.dart');
  }

  final emojis = args.contains('-e');
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
