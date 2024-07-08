part of '../gestu_helper.dart';

extension StringExtension on String {
  String toUpperCaseSentence() {
    String text = this;
    if (text.isNotEmpty) {
      text = text[0].toUpperCase();
    }
    if (length > 1) {
      text += substring(1).toLowerCase();
    }
    return text;
  }

  String toUpperCaseWords() {
    List<String> words = split(' ');
    return words.map((e) => e.toUpperCaseSentence()).join(' ');
  }

  String truncateString(int maxLength) {
    if (length <= maxLength) {
      return this;
    } else {
      return substring(0, maxLength);
    }
  }
}
