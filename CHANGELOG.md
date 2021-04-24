## 4.5.0

- No longer rely on pubspec.yaml for getting dependency imports ([#34])(https://github.com/fluttercommunity/import_sorter/issues/34)
- Improve formatting

## 4.4.3

- Fix packages that are prefixed with `flutter` ([#34])(https://github.com/fluttercommunity/import_sorter/issues/34)

## 4.4.2

- Add null-safety support ([#49](https://github.com/fluttercommunity/import_sorter/issues/49))

## 4.4.1

- Fix return when there are 0 imports ([#37](https://github.com/fluttercommunity/import_sorter/issues/37))

## 4.4.0

- The name of a file is yellow if it isn't changed. ([#36](https://github.com/fluttercommunity/import_sorter/issues/36))
- Display the number of imports sorted out of the total number of imports for a file. ([#36](https://github.com/fluttercommunity/import_sorter/issues/36))

## 4.3.1

- Remove analyzer CI

## 4.3.0

- Filter what files get sorted on the fly with arguments ([#27](https://github.com/fluttercommunity/import_sorter/issues/27))
- Upgrade all dependencies

## 4.2.2

- Add test_driver folder ([#30](https://github.com/fluttercommunity/import_sorter/issues/30))

## 4.2.1

- Replace relative import with package import

## 4.2.0

- Have relative imports come other imports ([#25](https://github.com/fluttercommunity/import_sorter/issues/25))

## 4.1.0

- Sort imports alphabetically ([#23](https://github.com/fluttercommunity/import_sorter/issues/23))

## 4.0.0

- Add `--no-comments` flag ([#20](https://github.com/fluttercommunity/import_sorter/issues/20))
- Add `--exit-if-changed` flag ([#21](https://github.com/fluttercommunity/import_sorter/issues/21))

## 3.1.0

- Use regex for the `ignored_files` option.

## 3.0.6

- Remove pub get feature. Was causing problems on linux ([#14](https://github.com/fluttercommunity/import_sorter/issues/14))

## 3.0.5

- Improve cli doc
- Change flutter emoji to 🐦

## 3.0.4

- Actually exit the program when pub get fails

## 3.0.3

- Fix removal of blank line when no imports

## 3.0.2

- Improve user output

## 3.0.1

- Move issue templates to correct location

## 3.0.0

- Fix problem with imports in multiline strings.
- Fix problem with code before imports.
- Add GitHub issue templates.
- Use args for arguments. This brings the addition of the `--help` flag.
- Add some sick looking terminal with colors. File names are now in green so its easier to see.

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
