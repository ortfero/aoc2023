import 'dart:io';

void main() async {
  final string = await File('input.txt').readAsString();
  final lines = string.split('\n');
  var sum = 0;
  for(var line in lines) {
    if (line.isEmpty) continue;
    final splitted = line.split(':');
    final sets = splitted[1].split(';');
    var maxR = 0, maxG = 0, maxB = 0;
    for(var set in sets) {
      var r = 0, g = 0, b = 0;
      final cubes = set.split(',');
      for(var cube in cubes) {
        final nColor = cube.trim().split(' ');
        final n = int.parse(nColor[0]);
        switch(nColor[1]) {
          case 'red':
            r += n;
            continue;
          case 'green':
            g += n;
            continue;
          case 'blue':
            b += n;
            continue;
        }
      }
      if(r > maxR) maxR = r;
      if(g > maxG) maxG = g;
      if(b > maxB) maxB = b;
    }
    final power = maxR * maxG * maxB;
    sum += power;
  }
  print(sum);
}
