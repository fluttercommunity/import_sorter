// 🎯 Dart imports:
import 'dart:io';

/// Get all the dart files for the project and the contents
Map<String, List<String>> dartFiles(String currentPath) {
  final dartFiles = <String, List<String>>{};
  final allContents = [
    ..._readDir(currentPath, 'lib'),
    ..._readDir(currentPath, 'bin'),
    ..._readDir(currentPath, 'test'),
    ..._readDir(currentPath, 'tests'),
    ..._readDir(currentPath, 'test_driver'),
  ];

  for (final fileOrDir in allContents) {
    if (fileOrDir is File && fileOrDir.path.endsWith('.dart')) {
      dartFiles[fileOrDir.path] = fileOrDir.readAsLinesSync();
    }
  }
  return dartFiles;
}

List<FileSystemEntity> _readDir(String currentPath, String name) {
  if (Directory('$currentPath/$name').existsSync()) {
    return Directory('$currentPath/test_driver').listSync(recursive: true);
  }
  return [];
}
