<!-- DO NOT REMOVE - contributor_list:data:start:["Matt-Gleich", "lig", "ImgBotApp", "jlnrrg"]:end -->

```txt
 ___  _____ ______   ________  ________  ________  _________
|\  \|\   _ \  _   \|\   __  \|\   __  \|\   __  \|\___   ___\
\ \  \ \  \\\__\ \  \ \  \|\  \ \  \|\  \ \  \|\  \|___ \  \_|
 \ \  \ \  \\|__| \  \ \   ____\ \  \\\  \ \   _  _\   \ \  \
  \ \  \ \  \    \ \  \ \  \___|\ \  \\\  \ \  \\  \|   \ \  \
   \ \__\ \__\    \ \__\ \__\    \ \_______\ \__\\ _\    \ \__\
    \|__|\|__|     \|__|\|__|     \|_______|\|__|\|__|    \|__|
    ________  ________  ________  _________  _______   ________
   |\   ____\|\   __  \|\   __  \|\___   ___\\  ___ \ |\   __  \
   \ \  \___|\ \  \|\  \ \  \|\  \|___ \  \_\ \   __/|\ \  \|\  \
    \ \_____  \ \  \\\  \ \   _  _\   \ \  \ \ \  \_|/_\ \   _  _\
     \|____|\  \ \  \\\  \ \  \\  \|   \ \  \ \ \  \_|\ \ \  \\  \|
       ____\_\  \ \_______\ \__\\ _\    \ \__\ \ \_______\ \__\\ _\
      |\_________\|_______|\|__|\|__|    \|__|  \|_______|\|__|\|__|
      \|_________|
```

# [import_sorter](https://pub.dev/packages/import_sorter) ![Pub Version](https://img.shields.io/pub/v/import_sorter)

[![Flutter Community: import_sorter](https://fluttercommunity.dev/_github/header/import_sorter)](https://github.com/fluttercommunity/community)

![test](https://github.com/fluttercommunity/import_sorter/workflows/test/badge.svg)
![format](https://github.com/fluttercommunity/import_sorter/workflows/format/badge.svg)

🎯 Dart package to automatically organize your dart imports. Any dart project supported! Will sorts imports alphabetically and then group them in the following order:

1. Dart imports
2. Flutter imports
3. Package imports
4. Project imports

Below is an example:

### Before

```dart
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/painting.dart';
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';
import 'anotherFile.dart';
import 'package:example_app/anotherFile2.dart';
import 'dart:async';
import 'dart:io';
import 'dart:js';
```

### After

```dart
// Dart imports:
import 'dart:async';
import 'dart:io';
import 'dart:js';

// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/physics.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'package:example_app/anotherFile2.dart';
import 'anotherFile.dart';
```

## 🚀 Installing

Simply add `import_sorter: ^4.5.1` to your `pubspec.yaml`'s `dev_dependencies`.

## 🏃‍♂️ Running

Once you've installed it simply run `flutter pub run import_sorter:main` (`pub run import_sorter:main` if normal dart application) to format every file dart file in your lib, bin, test, and tests folder! Don't worry if these folders don't exist.

## 💻 Command Line

- Add the `-e` flag to the run command and have emojis added to your imports 😄.
- If you're using a config in the `pubspec.yaml` you can have the program ignore it by adding `--ignore-config`.
- Want to make sure your files are sorted? Add `--exit-if-changed` to make sure the files are sorted. Good for things like CI.
- Have no comments before your imports by adding the `--no-comments` flag.
- Add the `-h` flag if you need any help from the command line!
- You can only run import_sorter on certain files by passing in a regular expression(s) that will only sort certain files. Below are two examples:
  - `pub run import_sorter:main bin/main.dart lib/args.dart` (only sorts bin/main.dart and lib/args.dart)
  - `pub run import_sorter:main lib\/* test\/*` (only sorts files in the lib and test folders)

## 🏗️ Config

If you use import_sorter a lot or need to ignore certain files you should look at using the config you put in your `pubspec.yaml`. Ignored files are in the format of regex. This regex is then applied to the project root path (the one outputted to the terminal). Below is an example config setting emojis to true and ignoring all files in the lib folder:

```yaml
import_sorter:
  emojis: true # Optional, defaults to false
  comments: false # Optional, defaults to true
  ignored_files: # Optional, defaults to []
    - \/lib\/*
```

If you need another example check the [example app's import_sorter configuration](https://github.com/fluttercommunity/import_sorter/blob/master/example/example_app/pubspec.yaml#L76).

## 🚨 [`pre-commit`](https://pre-commit.com/) Hook

There are two pre-commit hooks available: `dart-import-sorter` and `flutter-import-sorter`. They use `pub run` and `flutter pub run` respectively. Use the former for a generic Dart project and the latter for a Flutter project.

Using pre-commit hooks in your project:

- Install and configure `pre-commit`.
- Install and configure `import_sorter` using instructions above.
- Add the following to the `repos` section of your `.pre-commit-config.yaml`:

```yaml
- repo: https://github.com/fluttercommunity/import_sorter
  rev: 'master'
  hooks:
    - id: dart-import-sorter # use `flutter-import-sorter` for a Flutter project
```

- Run initial sort:

```shell
pre-commit run --all-files
```

## 🙋‍♀️🙋‍♂️ Contributing

All contributions are welcome! Just make sure that it's not an already existing issue or pull request.

<!-- DO NOT REMOVE - contributor_list:start -->

## 👥 Contributors

- **[@Matt-Gleich](https://github.com/Matt-Gleich)**

- **[@lig](https://github.com/lig)**

- **[@ImgBotApp](https://github.com/ImgBotApp)**

- **[@jlnrrg](https://github.com/jlnrrg)**

<!-- DO NOT REMOVE - contributor_list:end -->
