part of '../gestu_helper.dart';

class GestuTools {
  static String removeDiacritics(String str) {
    var withDia =
        'ÀÁÂÃÄÅàáâãäåÒÓÔÕÕÖØòóôõöøÈÉÊËèéêëðÇçÐÌÍÎÏìíîïÙÚÛÜùúûüÑñŠšŸÿýŽž';
    var withoutDia =
        'AAAAAAaaaaaaOOOOOOOooooooEEEEeeeeeCcDIIIIiiiiUUUUuuuuNnSsYyyZz';
    for (int i = 0; i < withDia.length; i++) {
      str = str.replaceAll(withDia[i], withoutDia[i]);
    }
    return str;
  }

  static String checkString(String? str, {String? nullValue}) {
    if (str == null || str.isEmpty) {
      return nullValue ?? '';
    }
    return str;
  }

  static String numToString(num? number, {String? nullValue}) {
    if (number == null) {
      return nullValue ?? '';
    }
    return number.toString();
  }

  static String amountFormat({
    num? amount,
    String currency = '\$',
    String? nullValue,
    bool withSpace = false,
    bool removeDecimals = false,
  }) {
    if (amount != null) {
      String numString = amount.toStringAsFixed(removeDecimals ? 0 : 2);
      List<String> parts = numString.split('.');
      RegExp pattern = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
      parts[0] = parts[0].replaceAllMapped(pattern, (match) => '${match[1]},');
      return '$currency${withSpace ? ' ' : ''}' '${parts.join('.')}';
    }
    return nullValue ?? '';
  }

  static String getRandString(int length) {
    var random = Random();
    const chars =
        'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890';

    final sb = StringBuffer();

    // First character should be a letter
    sb.write(chars[random.nextInt(52)]);

    for (var i = 1; i < length; i++) {
      sb.write(chars[random.nextInt(chars.length)]);
    }

    return sb.toString();
  }

  static int getRandInt(int min, int max) {
    return min + Random().nextInt(max - min + 1);
  }

  static num numericValue(String? value) {
    if (value != null) {
      final n = num.tryParse(value);
      String? textValue =
          (value.isEmpty || value == '-' || n == null) ? '0' : value;
      return num.parse((textValue));
    }
    return 0;
  }

  static double degreesToRadians(double degrees) {
    return degrees * pi / 180;
  }

  static String weekdayToString(int weekday,
      {bool short = false, String locale = 'ES'}) {
    DateTime date = DateTime(1986, 3, 5);
    int diff = weekday - date.weekday;
    date = date.add(Duration(days: diff));
    return DateFormat(short ? 'EE' : 'EEEE', locale).format(date);
  }

  static Future<dynamic> gestuNavigateTo(
    BuildContext context, {
    bool rootNavigator = false,
    bool fullscreeDialog = true,
    bool opaque = false,
    required Widget child,
  }) async {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      PageRouteBuilder(
        opaque: opaque,
        fullscreenDialog: fullscreeDialog,
        pageBuilder: (_, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
    );
  }

  static Future<void> gestuNavigateModalTo(
    BuildContext context, {
    bool rootNavigator = true,
    bool fullscreeDialog = true,
    required Widget child,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      MaterialPageRoute<List>(
        fullscreenDialog: fullscreeDialog,
        builder: (BuildContext context) {
          return child;
        },
      ),
    );
  }

  static Future<dynamic> gestuNavigatePushTo(
    BuildContext context, {
    bool rootNavigator = true,
    bool fullscreeDialog = true,
    required Widget child,
  }) {
    return Navigator.of(context, rootNavigator: rootNavigator).push(
      MaterialPageRoute<dynamic>(
        fullscreenDialog: fullscreeDialog,
        builder: (BuildContext context) {
          return child;
        },
      ),
    );
  }

  static Future<dynamic> gestuNavigateAndReplacement(
    BuildContext context, {
    required Widget child,
  }) async {
    return Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            child,
        transitionDuration: const Duration(milliseconds: 1500),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          );
        },
      ),
    );
  }

  static Future<dynamic> gestuNavigateAndRemoveUntil(
    BuildContext context, {
    Duration? duration,
    required Widget child,
    RoutePredicate? predicate,
  }) async {
    return Navigator.pushAndRemoveUntil(
      context,
      PageRouteBuilder(
        pageBuilder: (BuildContext context, Animation<double> animation,
                Animation<double> secondaryAnimation) =>
            child,
        transitionDuration: duration ?? const Duration(milliseconds: 1500),
        transitionsBuilder: (context, animation, _, child) {
          return FadeTransition(
            opacity: Tween<double>(begin: 0.0, end: 1.0).animate(
              CurvedAnimation(parent: animation, curve: Curves.easeOut),
            ),
            child: child,
          );
        },
      ),
      predicate ?? (route) => false,
    );
  }
}
