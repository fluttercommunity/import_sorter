// 🎯 Dart imports:
import 'dart:io';

// 📦 Package imports:
import 'package:yaml/yaml.dart';

// 🌎 Project imports:
import 'package:import_sorter/files.dart' as files;
import 'package:import_sorter/sort.dart' as sort;

void main(List<String> args) {
  /*
  Getting the package name and dependencies/dev-dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev-dependency names are used to identify package imports
  */
  final file = File('${Directory.current.path}/pubspec.yaml');
  final pubspecContents = loadYaml(file.readAsStringSync());

  // Getting all dependencies and package name
  final packageName = pubspecContents['name'];
  final dependencies = [];
  if (pubspecContents.containsKey('dependencies')) {
    dependencies.addAll(pubspecContents['dependencies'].keys);
  }
  if (pubspecContents.containsKey('dev_dependencies')) {
    dependencies.addAll(pubspecContents['dev_dependencies'].keys);
  }

  // Getting all the dart files for the project
  final dartFiles = files.dartFiles();

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
