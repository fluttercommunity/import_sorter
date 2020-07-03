// 🎯 Dart imports:
import 'dart:io';

void outputHelp() {
  final fancyAsciiTitle = '''
 ___  _____ ______   ________  ________  ________  _________
|\\  \\|\\   _ \\  _   \\|\\   __  \\|\\   __  \\|\\   __  \\|\\___   ___\\
\\ \\  \\ \\  \\\\\\__\\ \\  \\ \\  \\|\\  \\ \\  \\|\\  \\ \\  \\|\\  \\|___ \\  \\_|
 \\ \\  \\ \\  \\\\|__| \\  \\ \\   ____\\ \\  \\\\\\  \\ \\   _  _\\   \\ \\  \\
  \\ \\  \\ \\  \\    \\ \\  \\ \\  \\___|\\ \\  \\\\\\  \\ \\  \\\\  \\|   \\ \\  \\
   \\ \\__\\ \\__\\    \\ \\__\\ \\__\\    \\ \\_______\\ \\__\\\\ _\\    \\ \\__\\
    \\|__|\\|__|     \\|__|\\|__|     \\|_______|\\|__|\\|__|    \\|__|

 ________  ________  ________  _________  _______   ________
|\\   ____\\|\\   __  \\|\\   __  \\|\\___   ___\\\\  ___ \\ |\\   __  \\
\\ \\  \\___|\\ \\  \\|\\  \\ \\  \\|\\  \\|___ \\  \\_\\ \\   __/|\\ \\  \\|\\  \\
 \\ \\_____  \\ \\  \\\\\\  \\ \\   _  _\\   \\ \\  \\ \\ \\  \\_|/_\\ \\   _  _\\
  \\|____|\\  \\ \\  \\\\\\  \\ \\  \\\\  \\|   \\ \\  \\ \\ \\  \\_|\\ \\ \\  \\\\  \\|
    ____\\_\\  \\ \\_______\\ \\__\\\\ _\\    \\ \\__\\ \\ \\_______\\ \\__\\\\ _\\
   |\\_________\\|_______|\\|__|\\|__|    \\|__|  \\|_______|\\|__|\\|__|
   \\|_________|
''';

  stdout.write(fancyAsciiTitle);
  stdout.write('\nFlags:');
  stdout.write('\n  --emojis, -e       Add emojis to import comments.');
  stdout.write('\n  --help, -h         Display this help command.');
  stdout.write(
      '\n  --ignore-config    Ignore configuration in pubspec.yaml (if there is any).');
  stdout.write(
      "\n  --exit-if-changed  Return an error if any file isn't sorted. Good for CI.");
  stdout.write(
      "\n  --no-comments      Don't put any comments before the imports.\n");
  exit(0);
}
