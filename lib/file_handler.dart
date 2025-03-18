import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';

class FileHandler {
  static Character loadCharacter() {
    final file = File('data/characters.txt');
    if (!file.existsSync()) {
      print("Error: characters.txt 파일을 찾을 수 없습니다.");
      exit(1);
    }
    final data = file.readAsStringSync().split(',');
    return Character(
      "플레이어",
      int.parse(data[0]),
      int.parse(data[1]),
      int.parse(data[2]),
    );
  }

  static List<Monster> loadMonsters() {
    final file = File('data/monsters.txt');
    if (!file.existsSync()) {
      print("Error: monsters.txt 파일을 찾을 수 없습니다.");
      exit(1);
    }
    final lines = file.readAsLinesSync();
    return lines.map((line) {
      var data = line.split(',');
      return Monster(
        data[0],
        int.parse(data[1]),
        Random().nextInt(int.parse(data[2])) + 1,
      );
    }).toList();
  }

  static void saveResult(Character character, bool isWin) {
    try {
      final file = File("data/result.txt");
      String result =
          "캐릭터: ${character.name}, 남은 체력: ${character.health}, 결과: ${isWin ? '승리' : '패배'}\n";
      file.writeAsStringSync(result, mode: FileMode.append);
      print("💾 게임 결과가 저장되었습니다.");
    } catch (e) {
      print("⚠️ 게임 결과 저장 중 오류 발생: $e");
    } 
  } 
}
