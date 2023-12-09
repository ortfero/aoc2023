import 'dart:io';

int countWins(List<int> winNums, List<int> nums) {
  var c = 0;
  for(var n in nums) {
    if(winNums.contains(n)) c++;
  }
  return c;
}

int pointsOf(String line) {
  final game = line.split(':')[1].split('|');
  final winning = game[0]
    .split(' ')
    .where((it) => it.isNotEmpty)
    .map(int.parse)
    .toList();
  final actual = game[1]
    .split(' ')
    .where((it) => it.isNotEmpty)
    .map(int.parse)
    .toList();
  final wins = countWins(winning, actual);
  if(wins == 0) return 0;
  return 1 << (wins - 1);
}

void main() {
  final lines = File('input.txt').readAsLinesSync();
  print(lines.map(pointsOf).reduce((a, b) => a + b));
}
