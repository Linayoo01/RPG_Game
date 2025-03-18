import 'monster.dart';

class Character {
  String name;
  int health;
  int attack;
  int defense;

  Character(this.name, this.health, this.attack, this.defense);

  void attackMonster(Monster monster) {
    int damage = (attack - monster.defense).toInt();
    if (damage < 0) damage = 0;
    monster.health -= damage;
    print('$name이(가) ${monster.name}에게 $damage 만큼의 피해를 입혔습니다.');
  }

  void defend() {
    health += 5;
    print('$name이(가) 방어하여 체력을 회복했습니다. 현재 체력: $health');
  }

  void showStatus() {
    print('캐릭터 상태 - 이름: $name, 체력: $health, 공격력: $attack, 방어력: $defense');
  }
}
