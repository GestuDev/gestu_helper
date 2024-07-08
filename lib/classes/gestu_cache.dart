part of '../gestu_helper.dart';

class GestuCache {
  static GestuCache get instance => GestuCache();
  static final GestuCache _instance = GestuCache._internal();
  late Map<String, dynamic> _cache;

  GestuCache._internal() {
    _cache = {};
  }

  factory GestuCache() {
    return _instance;
  }

  dynamic getObjectForKey(String key) {
    return _cache[key];
  }

  void setObjectForKey(String key, dynamic value) {
    _cache[key] = value;
  }

  void dispose() {
    _cache.clear();
  }
}
