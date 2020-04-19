import 'dart:io';

/// Get all the dart files for the project and the contents
Map<String, List<String>> dartFiles() {
  final dartFiles = <String, List<String>>{};
  final dirContents =
      Directory('${Directory.current.path}/lib').listSync(recursive: true);
  for (final fileOrDir in dirContents) {
    if (fileOrDir is File && fileOrDir.path.endsWith('.dart')) {
      dartFiles[fileOrDir.path] = fileOrDir.readAsLinesSync();
    }
  }
  return dartFiles;
}
