// @dart=2.12

import 'dart:ui' as ui;

import 'package:hex_to_int_converter_web/main.dart' as entrypoint;

Future<void> main() async {
  await ui.webOnlyInitializePlatform();
  entrypoint.main();
}
