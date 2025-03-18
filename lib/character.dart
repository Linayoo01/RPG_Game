import 'monster.dart'; // 몬스터 클래스 추가

class Character {
  String name;
  int health;
  int attackPower;
  int defense;
  int level = 1;
  int experience = 0;
  bool itemUsed = false; // 아이템 사용 여부

  Character(this.name, this.health, this.attackPower, this.defense);

  void attackMonster(Monster monster) {
    int damage = (itemUsed ? attackPower * 2 : attackPower) - monster.defense;
    damage = damage > 0 ? damage : 0;
    monster.health -= damage;

    print("💥 $name(이)가 ${monster.name}에게 $damage 만큼의 피해를 입혔습니다.");
    print(
      "🩸 ${monster.name} 현재 체력: ${monster.health > 0 ? monster.health : 0}",
    ); // ✅ 몬스터 체력 출력
  }

  void defend() {
    print("$name(이)가 방어 자세를 취하여 피해를 줄였습니다.");
    health += 5; // 방어 시 체력 회복
  }

  void useItem() {
    if (itemUsed) {
      print("⚠️ 아이템은 한 번만 사용할 수 있습니다.");
      return;
    }
    itemUsed = true;
    print("🔥 아이템을 사용하여 다음 공격력이 두 배가 됩니다!");
  }

  void gainExperience(int exp) {
    experience += exp;
    print("✨ $name 경험치 +$exp 획득 (현재 경험치: $experience)");

    if (experience >= 50) { // 🚀 경험치 50 이상이면 한 번만 레벨업 수행
      experience -= 50; // 50만큼 차감
      levelUp();
    }
  }

  void levelUp() {
    level++;
    health += 10;
    attackPower += 2;
    defense += 1;
    experience = 0;
    print(
      "🎉 $name 레벨 업! (Lv.$level) 체력: $health, 공격력: $attackPower, 방어력: $defense",
    );
  }

  void showStatus() {
    print(
      "👤 캐릭터 상태 - 이름: $name, 체력: $health, 공격력: $attackPower, 방어력: $defense, 레벨: $level, 경험치: $experience",
    );
  }
}
