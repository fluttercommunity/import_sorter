# import_sorter ![Pub Version](https://img.shields.io/pub/v/import_sorter)

[![Flutter Community: import_sorter](https://fluttercommunity.dev/_github/header/import_sorter)](https://github.com/fluttercommunity/community)

![Analyzer](https://github.com/fluttercommunity/import_sorter/workflows/Analyzer/badge.svg) ![Dart CI](https://github.com/fluttercommunity/import_sorter/workflows/Dart%20CI/badge.svg)

📱 Dart package that automatically sorts all your flutter and dart imports. Any dart project supported! Sorts imports and reorders them based off the following format:

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
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/physics.dart';
import 'package:flutter/painting.dart';

// Package imports:
import 'package:intl/intl.dart';
import 'package:mdi/mdi.dart';
import 'package:provider/provider.dart';

// Project imports:
import 'anotherFile.dart';
import 'package:example_app/anotherFile2.dart';
```

## 🚀 Installing

Simply add `import_sorter: ^2.0.1` to your `dev_dependencies`

## 🏃‍♂️ Running

Once you've installed it simply run `flutter pub run import_sorter:main` (`pub run import_sorter:main` if normal dart application) to format every file dart file in your lib, bin, test, and tests folder! Don't worry if these folders don't exist.

## 💻 Command Line

- Add the `-e` flag to the run command and have emojis added to your imports 😄
- If your using a config in the `pubspec.yaml` you can have the program ignore it by adding `--ignore-config`

## 🏗️ Config

If you use import_sorter a lot or need to ignore certain files you should really look at using the config you put in your `pubspec.yaml`. Below is an example config:

```yaml
import_sorter:
  emojis: false  # Optional
  ignored_files:  # Optional
    - /lib/main.dart
```

If you need another example check the example app [Example app](example/example_app/pubspec.yaml)

## 🙋‍♀️🙋‍♂️ Contributing

All contributions are welcome! Just make sure that its not an already existing issue or pull request
