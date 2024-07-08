part of '../gestu_helper.dart';

class ParameterValidator extends Equatable {
  final Map<String, dynamic> estimatedData;

  ParameterValidator(Map<String, dynamic>? data) : estimatedData = data ?? {};

  ParameterValidator.fromMap(Map<dynamic, dynamic>? data)
      : estimatedData = _convertMap(data);

  static Map<String, dynamic> _convertMap(Map<dynamic, dynamic>? map) {
    if (map == null) {
      return {};
    }

    Map<String, dynamic> result = {};
    map.forEach((key, value) {
      if (key is String) {
        result[key] = value;
      }
    });
    return result;
  }

  void copyFromMap(Map data) {
    data.forEach((key, value) {
      estimatedData[key] = value;
    });
  }

  void setObject(String key, dynamic value) {
    if (value == null) {
      estimatedData.remove(key);
    } else {
      estimatedData[key] = value;
    }
  }

  Map? mapFromKey(String key) {
    if (estimatedData.containsKey(key) == false) {
      return null;
    } else if (estimatedData[key] is! Map) {
      return null;
    }
    return estimatedData[key];
  }

  String? stringFromKey(String key) {
    if (estimatedData.containsKey(key) == false) {
      return null;
    } else if (estimatedData[key] is! String) {
      return null;
    }
    return estimatedData[key];
  }

  List? listFromKey(String key) {
    if (estimatedData.containsKey(key) == false) {
      return null;
    } else if (estimatedData[key] is! List) {
      return null;
    }
    return estimatedData[key];
  }

  bool boolFromKey(String key) {
    if (estimatedData.containsKey(key) == false) {
      return false;
    } else if (estimatedData[key] is! bool) {
      return false;
    }
    return estimatedData[key];
  }

  int? intFromKey(String key) {
    if (estimatedData.containsKey(key) == false) {
      return null;
    } else if (estimatedData[key] is! int) {
      return null;
    }
    return estimatedData[key];
  }

  double? doubleFromKey(String key) {
    if (estimatedData.containsKey(key) == false) {
      return null;
    } else if (estimatedData[key] is! int && estimatedData[key] is! double) {
      return null;
    }
    return estimatedData[key].toDouble();
  }

  List<String> get keys => throw UnimplementedError();

  Map get arguments => throw UnimplementedError();

  @override
  List<Object?> get props => throw UnimplementedError();
}
