// 🎯 Dart imports:
import 'dart:io';

/// Get all the dart files for the project and the contents
Map<String, File> dartFiles(String currentPath, List<String> args) {
  final dartFiles = <String, File>{};
  final allContents = [
    ..._readDir(currentPath, 'lib'),
    ..._readDir(currentPath, 'bin'),
    ..._readDir(currentPath, 'test'),
    ..._readDir(currentPath, 'tests'),
    ..._readDir(currentPath, 'test_driver'),
  ];

  for (final fileOrDir in allContents) {
    if (fileOrDir is File && fileOrDir.path.endsWith('.dart')) {
      dartFiles[fileOrDir.path] = fileOrDir;
    }
  }

  // If there are only certain files given via args filter the others out
  var onlyCertainFiles = false;
  for (final arg in args) {
    if (!onlyCertainFiles) {
      onlyCertainFiles = arg.endsWith("dart");
    }
  }

  if (onlyCertainFiles) {
    final patterns = args.where((arg) => !arg.startsWith("-"));
    final filesToKeep = <String, File>{};

    for (final fileName in dartFiles.keys) {
      var keep = false;
      for (final pattern in patterns) {
        if (RegExp(pattern).hasMatch(fileName)) {
          keep = true;
          break;
        }
      }
      if (keep) {
        filesToKeep[fileName] = File(fileName);
      }
    }
    return filesToKeep;
  }

  return dartFiles;
}

List<FileSystemEntity> _readDir(String currentPath, String name) {
  if (Directory('$currentPath/$name').existsSync()) {
    return Directory('$currentPath/$name').listSync(recursive: true);
  }
  return [];
}
