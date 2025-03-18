import 'dart:io';
import 'dart:math';
import 'character.dart';
import 'monster.dart';
import 'file_handler.dart';

class Game {
  Character? character;
  List<Monster> monsters = [];
  int turnCounter = 0; // 몬스터 방어력 증가를 위한 턴 카운트

  Game() {
    loadCharacter();
    loadMonsters();
    applyBonusHealth(); // 보너스 체력 적용
  }

  void loadCharacter() {
    List<String> data = File(
      'data/characters.txt',
    ).readAsStringSync().split(',');
    character = Character(
      "Player",
      int.parse(data[0]),
      int.parse(data[1]),
      int.parse(data[2]),
    );
  }

  void loadMonsters() {
    List<String> lines = File('data/monsters.txt').readAsLinesSync();
    for (var line in lines) {
      List<String> parts = line.split(',');
      monsters.add(Monster(parts[0], int.parse(parts[1]), int.parse(parts[2])));
    }
  }

  void applyBonusHealth() {
    Random random = Random();
    if (random.nextDouble() < 0.3) {
      // 30% 확률
      character!.health += 10;
      print("🎉 보너스 체력을 얻었습니다! 현재 체력: ${character!.health}");
    }
  }

  void startGame() {
    print("🎮 게임을 시작합니다!");
    character!.showStatus();
    battle();
  }

  void battle() {
    while (monsters.isNotEmpty && character!.health > 0) {
      Monster monster = monsters.removeAt(0);
      print("\n🐉 새로운 몬스터 등장: ${monster.name}!");
      monster.showStatus();

      while (monster.health > 0 && character!.health > 0) {
        turnCounter++; // 턴 증가
        if (turnCounter % 3 == 0) {
          monster.increaseDefense();
        }

        print("\n⚔️ 행동을 선택하세요: ");
        print("   1) 공격  2) 방어  3) 아이템 사용(게임을 종료하려면 'n'을 입력하세요)");
        stdout.write("> ");

        String? choice = stdin.readLineSync()?.trim();

        if (choice == "1") {
          character!.attackMonster(monster);
        } else if (choice == "2") {
          character!.defend();
        } else if (choice == "3") {
          character!.useItem();
        } else if (choice == "n") {
          print("\n👋 게임을 종료합니다. 감사합니다!");
          stdout.flush(); // ✅ 프로그램 종료 전 출력 버퍼 비우기
          exit(0); // ✅ 즉시 게임 종료
        } else {
          print("⚠️ 잘못된 입력입니다. 1, 2, 3, 'n' 중 하나를 입력하세요.");
          continue;
        }

        if (monster.health > 0) {
          monster.attackCharacter(character!);
        }

        // ✅ 현재 체력 출력
        print("🩸 ${character!.name} 현재 체력: ${character!.health}");
        print("🩸 ${monster.name} 현재 체력: ${monster.health}");
      }

      if (character!.health <= 0) {
        print("💀 당신은 패배했습니다.");
        FileHandler.saveResult(character!, false);
        endGame(); // ✅ 패배 시 종료 여부 묻기
        return;
      } else {
        print("🎉 ${monster.name}(을)를 물리쳤습니다!");
        character!.gainExperience(50); // ✅ 경험치 추가 (자동으로 레벨업 확인)
      }
    }

    print("🏆 모든 몬스터를 처치했습니다! 승리!");
    FileHandler.saveResult(character!, true);
    endGame(); // ✅ 승리 시 종료 여부 묻기
  }

  // 🛠 게임 종료 및 재시작 로직
  void endGame() {
    print("[DEBUG] endGame() 실행됨");

    while (true) {
      print("\n게임이 종료되었습니다. 다시 시작하시겠습니까? (y/n)");
      stdout.write("> ");
      stdout.flush(); // ✅ 입력 버퍼 비우기

      String? choice = stdin.readLineSync()?.trim().toLowerCase();
      print("[DEBUG] 입력값: $choice");

      if (choice == "y") {
        print("\n🔄 게임을 다시 시작합니다!\n");
        restartGame();
        break;
      } else if (choice == "n") {
        print("\n👋 게임을 종료합니다. 감사합니다!");
        exit(0);
      } else {
        print("⚠️ 잘못된 입력입니다. 'y' 또는 'n'을 입력하세요.");
      }
    }
  }

  void restartGame() {
    print("[DEBUG] 게임 재시작 로직 실행");
    monsters.clear(); // 기존 몬스터 데이터 초기화
    loadCharacter(); // 캐릭터 재설정
    loadMonsters(); // 몬스터 재설정
    applyBonusHealth(); // 보너스 체력 재적용
    startGame(); // 게임 재시작
  }
}
