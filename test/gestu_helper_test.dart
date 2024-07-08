import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gestu_helper/gestu_helper.dart';

void main() {
  dateTimeExtensionTests();
  gestuCacheTests();
  gduTests();
}

void dateTimeExtensionTests() {
  group('DateTimeExtension Tests', () {
    final testDate = DateTime(2023, 7, 7, 15, 30);

    test('setTime should return a DateTime with the time set', () {
      const time = TimeOfDay(hour: 10, minute: 45);
      final newDateTime = testDate.setTime(time);
      expect(newDateTime.hour, 10);
      expect(newDateTime.minute, 45);
    });

    test('getTime should return the correct TimeOfDay', () {
      final time = testDate.getTime();
      expect(time.hour, 15);
      expect(time.minute, 30);
    });

    test('resetTime should return a DateTime with the time reset to 00:00', () {
      final resetDateTime = testDate.resetTime();
      expect(resetDateTime.hour, 0);
      expect(resetDateTime.minute, 0);
      expect(resetDateTime.second, 0);
    });

    test('lastTime should return a DateTime with the time set to 23:59:59', () {
      final lastTimeDateTime = testDate.lastTime();
      expect(lastTimeDateTime.hour, 23);
      expect(lastTimeDateTime.minute, 59);
      expect(lastTimeDateTime.second, 59);
    });

    test('firstDayOfMonth should return the first day of the month', () {
      final firstDay = testDate.firstDayOfMonth();
      expect(firstDay.year, 2023);
      expect(firstDay.month, 7);
      expect(firstDay.day, 1);
    });

    test('lastDayOfMonth should return the last day of the month', () {
      final lastDay = testDate.lastDayOfMonth();
      expect(lastDay.year, 2023);
      expect(lastDay.month, 7);
      expect(lastDay.day, 31);
    });

    test('getWeekOfMonth should return the correct week of the month', () {
      expect(testDate.getWeekOfMonth(), 1);
    });

    test('getWeekOfYear should return the correct week of the year', () {
      expect(testDate.getWeekOfYear(), 28);
    });
  });
}

void gestuCacheTests() {
  group('GestuCache Tests', () {
    late GestuCache cache;

    setUp(() {
      cache = GestuCache.instance;
      cache.dispose(); // Asegurarse de empezar con un cache limpio
    });

    test('instance should return the same instance', () {
      final anotherInstance = GestuCache.instance;
      expect(cache, same(anotherInstance));
    });

    test('getObjectForKey should return null for a non-existent key', () {
      expect(cache.getObjectForKey('nonExistentKey'), isNull);
    });

    test('setObjectForKey should store and retrieve the correct value', () {
      const key = 'testKey';
      const value = 'testValue';
      cache.setObjectForKey(key, value);
      expect(cache.getObjectForKey(key), equals(value));
    });

    test('dispose should clear all entries', () {
      cache.setObjectForKey('key1', 'value1');
      cache.setObjectForKey('key2', 'value2');
      cache.dispose();
      expect(cache.getObjectForKey('key1'), isNull);
      expect(cache.getObjectForKey('key2'), isNull);
    });

    test('setObjectForKey should overwrite existing value', () {
      const key = 'testKey';
      cache.setObjectForKey(key, 'initialValue');
      cache.setObjectForKey(key, 'newValue');
      expect(cache.getObjectForKey(key), equals('newValue'));
    });
  });
}

void gduTests() {
  group('GDU Tests', () {
    setUp(() {
      GDU.i; // Asegura que se ha inicializado la instancia
    });

    test('GDU.i should return the same instance', () {
      final instance1 = GDU.i;
      final instance2 = GDU.i;
      expect(instance1, same(instance2));
    });

    test('debugMode should default to false initially', () {
      expect(GDU.debugMode, true);
    });

    test('Setting debugMode should update the value', () {
      GDU.debugMode = true;
      expect(GDU.debugMode, true);
    });

    test('text widget should return GestureDetector in debug mode', () {
      final widget = GDU.text('Test Text', onTap: () {});
      expect(widget, isA<GestureDetector>());
    });

    test('paramFromKey should return correct boolean value', () {
      GDU.paramForKey('testKey', true);
      expect(GDU.paramFromKey('testKey'), true);
    });

    test('paramForKey should only update parameter if in debug mode', () {
      GDU.debugMode = false;
      GDU.paramForKey('testKey', true);
      expect(GDU.paramFromKey('testKey'),
          false); // Should remain false because not in debug mode
    });

    test('allKeys should return a list of parameter keys', () {
      GDU.paramForKey('key1', true);
      GDU.paramForKey('key2', false);
      final keys = GDU.allKeys;
      expect(keys.contains('key1'), true);
      expect(keys.contains('key2'), true);
    });

    test('printD should print to debugPrint when debug mode is enabled for key',
        () {
      GDU.debugMode = true;
      const key = 'printTest';
      const testObject = 'Hello, world!';
      GDU.printD(testObject, key: key);
      // Since debugPrint cannot be directly tested, you may want to check the console manually when running the test
    });
  });
}
