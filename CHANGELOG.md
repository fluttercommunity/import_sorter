## 3.0.1

- Move issue templates to correct location

## 3.0.0

- Fix problem with imports in multiline strings
- Fix problem with code before imports
- Add GitHub issue templates
- Use args for arguments. This brings the addition of the `--help` flag
- Add some sick looking terminal output as seen below. File names are now in green so its easier to see

```
┏━━🏃‍  Running: pub get
┃  ┗━━✅  Ran pub get
┃
┣━━🏭  Sorting Files
┃  ┣━━✅  Formatted /lib/sort.dart
┃  ┣━━✅  Formatted /lib/files.dart
┃  ┣━━✅  Formatted /lib/args.dart
┃  ┣━━✅  Formatted /bin/main.dart
┃  ┗━━✅  Formatted /test/sort_test.dart
┃
┗━━😄  Formatted 5 files in 0.58 seconds
```

## 2.0.3

- Fix problem when no `dev_dependencies are present`

## 2.0.2

- Drop process_run dependant
- Change run emoji

## 2.0.1

- Resolve minor linting issues

## 2.0.0

- Add `pubspec.yaml` config option
- Improve terminal output
- Clean up code
- Add ignore_files file options in config

## 1.0.10

- Moved package to Flutter Community

## 1.0.9

- Resolve issue #3 with commented out files

## 1.0.8

- Resolve issue #2 with transitive dependencies

## 1.0.7

- Fix duplicate imports when contain same package name

## 1.0.6

- Ignore /lib/generated_plugin_registrant.dart for flutter projects

## 1.0.5

- Update documentation
- Add emoji flag

## 1.0.4

- Fix spacing of import blocks

## 1.0.3

- Fix dev dependency problem
- Add new line to end of file even if there are no imports

## 1.0.2

- Resolve dart lint issues

## 1.0.1

- Remove double call to sort
- Add pub badge to `README.md`

## 1.0.0

- Initial release
