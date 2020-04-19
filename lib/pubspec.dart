import 'dart:io';

import 'package:yaml/yaml.dart';

YamlMap read() {
  final file = File('${Directory.current.path}/pubspec.yaml');
  if (file.existsSync()) {
    return loadYaml(file.readAsStringSync());
  }
  print("❌ Failed to read from pubspec.yaml");
}
