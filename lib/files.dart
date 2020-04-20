// Dart imports:
import 'dart:io';

/// Get all the dart files for the project and the contents
Map<String, List<String>> dartFiles() {
  final dartFiles = <String, List<String>>{};
  final allContents = [
    ...Directory('${Directory.current.path}/lib').listSync(recursive: true)
  ];
  if (Directory('${Directory.current.path}/bin').existsSync()) {
    allContents.addAll(
        Directory('${Directory.current.path}/bin').listSync(recursive: true));
  }
  if (Directory('${Directory.current.path}/test').existsSync()) {
    allContents.addAll(
        Directory('${Directory.current.path}/test').listSync(recursive: true));
  }
  if (Directory('${Directory.current.path}/tests').existsSync()) {
    allContents.addAll(
        Directory('${Directory.current.path}/tests').listSync(recursive: true));
  }
  for (final fileOrDir in allContents) {
    if (fileOrDir is File && fileOrDir.path.endsWith('.dart')) {
      dartFiles[fileOrDir.path] = fileOrDir.readAsLinesSync();
    }
  }
  return dartFiles;
}
