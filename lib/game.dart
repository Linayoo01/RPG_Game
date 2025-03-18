import 'character.dart';
import 'monster.dart';
import 'dart:io';
import 'dart:math';

class Game {
  Character? character;
  List<Monster> monsters = [];

  Game() {
    loadCharacter();
    loadMonsters();
  }

  void loadCharacter() {
    List<String> data = File('data/characters.txt').readAsStringSync().split(',');
    character = Character("Player", int.parse(data[0]), int.parse(data[1]), int.parse(data[2]));
  }

  void loadMonsters() {
    List<String> lines = File('data/monsters.txt').readAsLinesSync();
    for (var line in lines) {
      List<String> parts = line.split(',');
      monsters.add(Monster(parts[0], int.parse(parts[1]), int.parse(parts[2])));
    }
  }

  void startGame() {
    print("게임을 시작합니다!");
    character?.showStatus();
    battle();
  }

  void battle() {
    while (monsters.isNotEmpty && character!.health > 0) {
      Monster monster = monsters.removeAt(0);
      print("\n새로운 몬스터가 나타났습니다!");
      monster.showStatus();

      while (monster.health > 0 && character!.health > 0) {
        print("\n행동을 선택하세요: 1) 공격 2) 방어");
        String? choice = stdin.readLineSync();

        if (choice == "1") {
          character!.attackMonster(monster);
        } else if (choice == "2") {
          character!.defend();
        }

        if (monster.health > 0) {
          monster.attackCharacter(character!);
        }
      }

      if (character!.health <= 0) {
        print("게임 오버! 캐릭터가 사망했습니다.");
        return;
      } else {
        print("${monster.name}을(를) 물리쳤습니다!");
      }
    }

    print("축하합니다! 모든 몬스터를 물리쳤습니다.");
  }
}
