import 'dart:io'; 
import 'character.dart';
import 'monster.dart';
import 'file_handler.dart';

void main() {
  while (true) {  
    startGame();

    print("\n게임이 종료되었습니다. 다시 시작하시겠습니까? (y/n)");
    stdout.write("> ");

    String? choice;
    try {
      choice = stdin.readLineSync()?.trim().toLowerCase();
    } catch (e) {
      print("⚠️ 입력 오류 발생: $e");
      continue;
    }

    if (choice == "n") {
      print("\n👋 게임을 종료합니다. 감사합니다!");
      exit(0); 
    } else if (choice != "y") {
      print("⚠️ 잘못된 입력입니다. 기본적으로 게임을 다시 시작합니다.");
    }
  }
}

void startGame() {
  Character player = FileHandler.loadCharacter();
  List<Monster> monsters = FileHandler.loadMonsters();

  print("\n🎮 게임을 시작합니다!\n");
  player.showStatus();

  for (Monster monster in monsters) {
    print("\n👾 새로운 몬스터 등장: ${monster.name}!");
    monster.showStatus();

    while (monster.health > 0 && player.health > 0) {
      print("\n행동을 선택하세요: 1) 공격  2) 방어  3) 아이템 사용 (게임을 종료하려면 'n'을 입력하세요)");
      stdout.write("> ");

      String? choice;
      try {
        choice = stdin.readLineSync()?.trim();
      } catch (e) {
        print("⚠️ 입력 오류 발생: $e");
        continue;
      }

      if (choice == "1") {
        player.attackMonster(monster);
      } else if (choice == "2") {
        player.defend();
      } else if (choice == "3") {
        player.useItem();
      } else if (choice == "n") {
        print("\n👋 게임을 종료합니다. 감사합니다!");
        exit(0);
      } else {
        print("⚠️ 잘못된 입력입니다. 1, 2, 3, 'n' 중 하나를 입력하세요.");
        continue;
      }

      if (monster.health > 0) {
        monster.attackCharacter(player);
      }
    }

    if (player.health <= 0) {
      print("\n😢 당신은 패배했습니다.");
      try {
        FileHandler.saveResult(player, false);
      } catch (e) {
        print("⚠️ 게임 결과 저장 중 오류 발생: $e");
      }
      return;
    } else {
      print("\n🎉 ${monster.name}을(를) 물리쳤습니다!");
      player.gainExperience(50);
    }
  }

  print("\n🏆 모든 몬스터를 처치했습니다! 승리!");
  try {
    FileHandler.saveResult(player, true);
  } catch (e) {
    print("⚠️ 게임 결과 저장 중 오류 발생: $e");
  }
}
