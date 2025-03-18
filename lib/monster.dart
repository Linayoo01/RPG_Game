import 'dart:math';
import 'character.dart';

class Monster {
  String name;
  int health;
  int attack;
  int defense = 0;

  // 생성자에서 초기화
  Monster(this.name, this.health, int attackMax) : attack = Random().nextInt(attackMax) + 1;

  void attackCharacter(Character character) {
    int damage = (attack - character.defense).toInt();
    if (damage < 0) damage = 0;
    character.health -= damage;
    print('$name이(가) ${character.name}에게 $damage 만큼의 피해를 입혔습니다.');
  }

  void showStatus() {
    print('몬스터 상태 - 이름: $name, 체력: $health, 공격력: $attack');
  }
}
