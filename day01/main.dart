import 'dart:io';


// I hate allocations

class Char {
  static const int x0 = 48;
  static const int x9 = 57;
  static const int e = 101;
  static const int f = 102;
  static const int g = 103;
  static const int h = 104;
  static const int i = 105;
  static const int n = 110;
  static const int o = 111;
  static const int r = 114;
  static const int s = 115;
  static const int t = 116;
  static const int u = 117;
  static const int v = 118;
  static const int w = 119;
  static const int x = 120;
}

const List<List<int>> digits = [
  [],
  [Char.o, Char.n, Char.e],
  [Char.t, Char.w, Char.o],
  [Char.t, Char.h, Char.r, Char.e, Char.e],
  [Char.f, Char.o, Char.u, Char.r],
  [Char.f, Char.i, Char.v, Char.e],
  [Char.s, Char.i, Char.x],
  [Char.s, Char.e, Char.v, Char.e, Char.n],
  [Char.e, Char.i, Char.g, Char.h, Char.t],
  [Char.n, Char.i, Char.n, Char.e]
];

bool isDigit(int char)
  => char >= Char.x0 && char <= Char.x9;

int toDigit(int char)
  => char - Char.x0;

bool matchDigit(List<int> chars, int i, List<int> digit) {
  for(var j = 0; j != digit.length; j++) {
    if(chars[i + j] != digit[j]) return false;
  }
  return true;
}

int parseDigit(List<int> chars, int i, int n) {
  switch(chars[i]) {
    case Char.o:
      return matchDigit(chars, i, digits[1]) ? 1 : 0;
    case Char.t:
      if(matchDigit(chars, i, digits[2])) return 2;
      if(n < 5) return 0;
      return matchDigit(chars, i, digits[3]) ? 3 : 0;
    case Char.f:
      if(n < 4) return 0;
      if(matchDigit(chars, i, digits[4])) return 4;
      return matchDigit(chars, i, digits[5]) ? 5 : 0;
    case Char.s:
      if(matchDigit(chars, i, digits[6])) return 6;
      if(n < 5) return 0;
      return matchDigit(chars, i, digits[7]) ? 7 : 0;
    case Char.e:
      if(n < 5) return  0;
      return matchDigit(chars, i, digits[8]) ? 8 : 0;
    case Char.n:
      if(n < 4) return 0;
      return matchDigit(chars, i, digits[9]) ? 9 : 0;
    default:
      return 0;
  }
} 

int leftmostDigit(List<int> chars, int i, int n) {
  while(n > 2) {
    final d = parseDigit(chars, i, n);
    if(d != 0) return d;
    i++;
    n--;
  }
  return 0;
}

int rightmostDigit(List<int> chars, int i, int n) {
  if( n < 3) return 0;
  var j = i + n - 3;
  var m = 3;
  while(j != i - 1) {
    final d = parseDigit(chars, j, m);
    if(d != 0) return d;
    j--;
    m++;
  }
  return 0;
}

void main() {
  final lines = File('input.txt').readAsLinesSync();
  var sum = 0;
  for(var line in lines) {
    if (line.isEmpty) continue;
    final chars = line.codeUnits;
    var firstDigit = 0;
    var i = 0;
    for (i = 0; i != chars.length; i++) {
      final r = chars[i];
      if (!isDigit(r)) continue; 
      firstDigit = toDigit(r);
      break;
    }
    if (i > 2) {
      final digit = leftmostDigit(chars, 0, i);
      if (digit != 0) firstDigit = digit;
    }
    var lastDigit = 0;
    for (i = 0; i != chars.length; i++) {
      final r = chars[chars.length - 1 - i];
      if (!isDigit(r)) continue;
      lastDigit = toDigit(r);
      break;
    }
    if (chars.length - i > 3) {
      final digit = rightmostDigit(chars, i + 1, chars.length - i - 1);
      if (digit != 0) lastDigit = digit;
    }
    final n = firstDigit * 10 + lastDigit;
    sum += n;
  }
  print(sum);
}
