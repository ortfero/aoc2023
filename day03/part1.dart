import 'dart:io';


class Char {
  static const dot = 46;
  static const x0 = 48;
  static const x9 = 57;
}

bool isDigit(int char)
  => char >= Char.x0 && char <= Char.x9;

int toDigit(int char)
  => char - Char.x0;

bool isSymbol(int char) =>
  !(char == Char.dot || isDigit(char));

typedef SymbolInfo = (int i, int j, int s);
typedef NumberInfo = (int i, int j, int n);
typedef Adjacent = (SymbolInfo si, NumberInfo ni);

NumberInfo? tryNumber(List<List<int>> chars, int i, int j) {
  final line = chars[i];
  if(i == -1 || j == -1 || i == chars.length || j == line.length) return null;
  if(!isDigit(line[j])) return null;
  while(j != -1 && isDigit(line[j])) {
    j--;
  }
  var k = j + 1;
  var n = 0;
  while(k != line.length && isDigit(line[k])) {
    n *= 10;
    n += toDigit(line[k]);
    k++;
  }
  return (i, j + 1, n);
}

Iterable<Adjacent> adjacents(List<List<int>> chars) sync* {
  for(var i = 0; i != chars.length; i++) {
    for(var j = 0; j != chars[i].length; j++) {
      final c = chars[i][j];
      if(!isSymbol(c)) continue;
      for(var k = -1; k != 2; k++) {
        for(var l = -1; l != 2; l++) {
          final n = tryNumber(chars, i + k, j + l);
          if(n != null) yield ((i, j, c), n);
        }
      }
    } 
  }
}

int sum(List<List<int>> chars) =>
  adjacents(chars).map((e) => e.$2).toSet().toList().map((e) => e.$3).reduce((a, b) => a + b);

void main() {
  final lines = File('input.txt').readAsLinesSync();
  final chars = lines.map((line) => line.codeUnits).toList();
  print(sum(chars));
}
