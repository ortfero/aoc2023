import 'dart:io';


int countWins(List<int> winNums, List<int> nums) {
  var c = 0;
  for(var n in nums) {
    if(winNums.contains(n)) c++;
  }
  return c;
}


(int, int) parseWins(String line) {
  final parts = line.split(':');
  final id = int.parse(parts[0].split(' ').last);
  final game = parts[1].split('|');
  final winNums = game[0]
    .split(' ')
    .where((it) => it.isNotEmpty)
    .map(int.parse)
    .toList();
  final nums = game[1]
    .split(' ')
    .where((it) => it.isNotEmpty)
    .map(int.parse)
    .toList();
  final wins = countWins(winNums, nums);
  return (id, wins);
}


void count(int n, List<int> wins, List<int> counts) {
  counts[n] += 1;
  for(var i = n + 1; i != n + wins[n] + 1; i++) {
    count(i, wins, counts);
  }
}


void main() {
  final lines = File('input.txt').readAsLinesSync();
  final wins = List<int>.filled(lines.length + 1, 0);
  lines.map(parseWins).forEach((it) => wins[it.$1] = it.$2);
  final counts = List<int>.filled(lines.length + 1, 0);
  for(var id = 0; id != lines.length; id++) {
    count(id + 1, wins, counts);
  }
  print(counts.reduce((acc, it) => acc + it));
}
