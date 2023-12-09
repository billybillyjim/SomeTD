extends Object
class_name s

class Skill:

	const MaxEXP: int = 9000000000000000000
	const MaxLevel: int = 350

	var skill_name: String = ""
	var gained_xp_last_tick: bool = false

	var level: int = 1
	var description: String = ""
	var boost: int = 0
	var _experience: int = 0

	func _init():
		self._experience = 0

	func reset_experience():
		_experience = 0

	func gain_experience(amount: int):
		if amount > 0:
			if _experience + amount > _experience and _experience + amount < MaxEXP:
				_experience += amount
			_experience = min(_experience, MaxEXP)
			
				

		if _experience >= get_experience_required(get_skill_level_unboosted()):
			level_up();
		

	func get_experience() -> int:
		return _experience

	func get_progress() -> float:
		if level >= MaxLevel:
			return 100
		var exp_last_level = get_experience_required(level - 1)
		var exp_to_level = get_experience_required(level) - exp_last_level
		var exp_progress = _experience - exp_last_level
		return (exp_progress / exp_to_level) * 100

	static func get_experience_required(level: int) -> float:
		var exp = 0
		for i in range(level):
			exp += 100.0 * pow(1.1, i)
		return max(exp, 0)

	func get_skill_level() -> int:
		return level + boost

	func get_skill_level_unboosted() -> int:
		return level

	func set_skill_level(new_level: int):
		level = min(new_level, MaxLevel)
		
	func level_up():
		set_skill_level(get_skill_level_unboosted() + 1);
		if _experience >= get_experience_required(get_skill_level_unboosted()):
			level_up();
		

	func load_experience(amount: int):
		if amount < 0:
			return
		level = 1
		_experience = 0
		_experience += amount

		while _experience >= get_experience_required(get_skill_level_unboosted()):
			if level >= MaxLevel:
				break
			level += 1
