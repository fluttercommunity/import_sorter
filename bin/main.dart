import 'dart:io';

import 'package:tint/tint.dart';

import './import_sorter.dart' as import_sorter;

void main(List<String> args) {
  stdout.writeln(
    '\n'
    '${'WARNING:'.yellow()} This command is deprecated, '
    'please use ${'import_sorter'.green()} instead'
    '\n',
  );

  import_sorter.main(args);
}
