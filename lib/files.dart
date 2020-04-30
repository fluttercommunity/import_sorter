// 🎯 Dart imports:
import 'dart:io';

/// Get all the dart files for the project and the contents
Map<String, List<String>> dartFiles(String currentPath) {
  final dartFiles = <String, List<String>>{};
  final allContents = [
    ...Directory('$currentPath/lib').listSync(recursive: true)
  ];
  if (Directory('$currentPath/bin').existsSync())
    allContents.addAll(Directory('$currentPath/bin').listSync(recursive: true));
  if (Directory('$currentPath/test').existsSync())
    allContents
        .addAll(Directory('$currentPath/test').listSync(recursive: true));
  if (Directory('$currentPath/tests').existsSync())
    allContents
        .addAll(Directory('$currentPath/tests').listSync(recursive: true));
  for (final fileOrDir in allContents) {
    if (fileOrDir is File && fileOrDir.path.endsWith('.dart'))
      dartFiles[fileOrDir.path] = fileOrDir.readAsLinesSync();
  }
  return dartFiles;
}
