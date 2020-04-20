// Dart imports:
import 'dart:io';

// Project imports:
import 'package:import_sorter/files.dart' as files;
import 'package:import_sorter/pubspec.dart' as pubspec;
import 'package:import_sorter/sort.dart' as sort;

void main() async {
  /*
  Getting the package name and dependencies/dev-dependencies
  Package name is one factor used to identify project imports
  Dependencies/dev-dependency names are used to identify package imports
  */
  final pubspecContents = pubspec.read();
  final packageName = pubspecContents['name'];
  final dependencies = [];
  if (pubspecContents.containsKey('dependencies')) {
    dependencies.addAll(pubspecContents['dependencies'].keys);
  }
  if (pubspecContents.containsKey('dev-dependencies')) {
    dependencies.addAll(pubspecContents['dev-dependencies'].keys);
  }
  // Getting all the dart files for the project
  final dartFiles = files.dartFiles();
  for (final filePath in dartFiles.keys) {
    File(filePath).writeAsStringSync(sort.sortImports(
      dartFiles[filePath],
      packageName,
      dependencies,
    ));
    print('✅ Formatted ${filePath.replaceAll(Directory.current.path, '')}');
  }
}