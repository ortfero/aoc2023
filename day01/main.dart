import 'dart:io';

const digits = [
  'one',
  'two',
  'three',
  'four',
  'five',
  'six',
  'seven',
  'eight',
  'nine'
];

int findLeftDigit(String s) {
  var i = s.length;
  var d = 0;
  for (var k = 0; k != digits.length; k++) {
    final j = s.indexOf(digits[k]);
    if (j == -1 || j >= i) continue;
    i = j;
    d = k + 1;
  }
  return d;
}

int findRightDigit(String s) {
  var i = -1;
  var d = 0;
  for (var k = 0; k != digits.length; k++) {
    final j = s.indexOf(digits[k]);
    if (j == -1 || j <= i) continue;
    i = j;
    d = k + 1;
  }
  return d;
}

void main() async {
  final string = await File('input.txt').readAsString();
  // final lines = string.split('\n');
  final lines = ['five1oneight'];
  var sum = 0;
  for (var line in lines) {
    if (line.isEmpty) continue;
    final runes = line.runes.toList();
    var firstDigit = 0;
    var i = 0;
    for (i = 0; i != runes.length; i++) {
      final r = runes[i];
      if (r > 57 || r < 48) continue;
      firstDigit = r - 48;
      break;
    }
    if (i > 2) {
      final digit = findLeftDigit(line.substring(0, i));
      if (digit != 0) firstDigit = digit;
    }
    var lastDigit = 0;
    for (i = 0; i != runes.length; i++) {
      final r = runes[runes.length - 1 - i];
      if (r > 57 || r < 48) continue;
      lastDigit = r - 48;
      break;
    }
    if (i > 2) {
      final digit = findRightDigit(line.substring(runes.length - i));
      if (digit != 0) lastDigit = digit;
    }
    final n = firstDigit * 10 + lastDigit;
    sum += n;
  }
  print(sum);
}
