part of '../gestu_helper.dart';

///Gestu Debug Utilities
///
///Utilidades para activar o desactivar el debug de las cosas
class GDU {
  static GDU? _instance;
  GDU._();

  /// Instance to access
  static GDU get i => GDU.init();
  factory GDU.init() {
    if (_instance == null) {
      _instance = GDU._();
      _instance!._debugMode = kDebugMode;
      _instance!._parameters = {};
    }
    return _instance!;
  }
  static Future<void> initialize() async {
    GDU.init();
    _instance!._packageInfo = await PackageInfo.fromPlatform();
    return;
  }

  static Widget text(String text, {VoidCallback? onTap}) {
    return debugMode
        ? GestureDetector(
            onTap: onTap == null
                ? null
                : () {
                    Clipboard.setData(
                      ClipboardData(text: text),
                    );
                    onTap.call();
                  },
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.purple, fontSize: 10),
            ),
          )
        : const SizedBox.shrink();
  }

  static List<String> get allKeys => i._parameters.keys.toList();
  late Map<String, bool> _parameters;
  static bool paramFromKey(String key) {
    return i._paramFromKey(key);
  }

  bool _paramFromKey(String key) {
    return _parameters[key] ?? false;
  }

  static paramForKey(String key, bool value) {
    i._paramForKey(key, value);
  }

  void _paramForKey(String key, bool value) {
    _parameters[key] = _debugMode ? value : false;
  }

  late bool _debugMode;
  static set debugMode(bool value) => i._debugMode = kDebugMode ? value : false;
  static bool get debugMode => i._debugMode;

  late PackageInfo _packageInfo;
  static PackageInfo get packageInfo => i._packageInfo;

  static VersionHelper get version => VersionHelper(
        version: GDU.packageInfo.version,
        buildNumber: GDU.packageInfo.buildNumber,
      );

  static void printD(Object object, {String? key}) {
    if (key != null && paramFromKey(key)) {
      debugPrint('$key - $object');
    }
  }
}
