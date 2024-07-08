part of '../gestu_helper.dart';

class VersionHelper {
  late int major;
  late int minor;
  late int patch;
  late int build;
  VersionHelper({String? version, String? buildNumber}) {
    major = 0;
    minor = 0;
    patch = 0;
    build = int.tryParse(buildNumber ?? '0') ?? 0;
    if (version != null) {
      List v = version.split('.');
      major = v.isNotEmpty ? int.tryParse(v[0]) ?? 0 : 0;
      minor = v.length > 1 ? int.tryParse(v[1]) ?? 0 : 0;
      patch = v.length > 2 ? int.tryParse(v[2]) ?? 0 : 0;
    }
  }

  int _binVal(VersionHelper b, {bool buildCount = true}) {
    int isMajor = 0;
    if (major >= b.major) {
      isMajor += 1000;
    }
    if (minor >= b.minor) {
      isMajor += 100;
    }
    if (patch >= b.patch) {
      isMajor += 10;
    }
    if (build >= b.build && buildCount) {
      isMajor += 1;
    }
    return isMajor;
  }

  bool isMajor(VersionHelper b) {
    int aValue = _binVal(b);
    int bValue = b._binVal(this);
    // print("a: $aValue , b:$bValue");
    return aValue > bValue && !isEqual(b);
  }

  bool isMinor(VersionHelper b) {
    return b.isMajor(this) && !isEqual(b);
  }

  bool isEqual(VersionHelper b) {
    return major == b.major &&
        minor == b.minor &&
        patch == b.patch &&
        build == b.build;
  }

  bool isMajorVersion(VersionHelper b) {
    int aValue = _binVal(b, buildCount: false);
    int bValue = b._binVal(this);
    // print("a: $aValue , b:$bValue");
    return aValue > bValue && !isEqual(b);
  }

  bool isMinorVersion(VersionHelper b) {
    return b.isMajorVersion(this) && !isEqual(b);
  }

  bool isEqualVersion(VersionHelper b) {
    return major == b.major && minor == b.minor && patch == b.patch;
  }

  String get versionAndBuild => '$major.$minor.$patch ($build)';
  String get version => '$major.$minor.$patch';
}
