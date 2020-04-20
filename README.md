# import_sorter ![Pub Version](https://img.shields.io/pub/v/import_sorter)

📱 Dart package that automatically sorts all your flutter and dart imports. Flutter and regular dart applications supported! Sorts imports and reorders them based off the following format:

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

Simply add `import_sorter: ^1.0.1` to your `dev-dependencies`

## 🏃‍♂️ Running

Once you've installed it simply run `flutter pub run import_sorter:main` to format every file dart file in your lib, bin, test, and tests folder! Don't worry if these folders don't exist.

## 🙋‍♀️🙋‍♂️ Contributing

All contributions are welcome! Just make sure that its not an already existing issue or pull request
