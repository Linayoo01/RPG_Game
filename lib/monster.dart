import 'character.dart';

class Monster {
  String name;
  int health;
  int attackPower;
  int defense = 0; // 기본 방어력
  int turnCounter = 0; // 방어력 증가를 위한 턴 카운트

  Monster(this.name, this.health, this.attackPower);

void attackCharacter(Character character) {
  int damage = attackPower - character.defense;
  damage = damage > 0 ? damage : 0;
  character.health -= damage;

  print("💥 $name(이)가 ${character.name}에게 $damage 만큼의 피해를 입혔습니다.");
  print("🩸 ${character.name} 현재 체력: ${character.health > 0 ? character.health : 0}"); // 캐릭터 체력 출력
}


  void increaseDefense() {
    defense += 2;
    print("🛡️ $name의 방어력이 증가했습니다! 현재 방어력: $defense");
  }

  void showStatus() {
    print("🐉 몬스터 상태 - 이름: $name, 체력: $health, 공격력: $attackPower, 방어력: $defense");
  }
}
