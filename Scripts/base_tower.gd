extends Sprite2D

@onready var area_2d = $Area2D
@export var bulletType : PackedScene

var current_shots = 0
var max_shots = 1
var fire_speed = 1
var time_since_last_fire = 0
var level : s.Skill
var damage := 1 : get = _get_damage
var base_cost := 10
var attack_type := 'Sword'
var title = "not set"
var range = 1 :
	set = _set_range,
	get = _get_range
	
func _get_damage():
	return damage * level.level 
	
func _get_range():
	return range * level.level

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta = delta * TimeManager.play_speed
	if time_since_last_fire < fire_speed:
		time_since_last_fire += delta
	else:
		time_since_last_fire -= fire_speed
		
		for area in area_2d.get_overlapping_areas():
			if area.get_parent() != null:
				var enemy = area.get_parent()
				
				if not enemy or not enemy.has_method("take_damage"):
					continue
				
				if current_shots < max_shots:
					current_shots += 1
					var new_bullet = bulletType.instantiate()
					add_child(new_bullet)
					new_bullet.target = area.get_parent()
					new_bullet.global_position = self.global_position
					new_bullet.tower = self
					new_bullet.look_at(enemy.global_position)
					new_bullet.rotate(1.5708)

func set_values(name_string, elevation = 1):
	var tower_data = TowerManager.tower_datas[name_string]
	self.level = s.Skill.new()
	self.title = name_string
	self.name = name_string
	self.current_shots = 0
	self.base_cost = tower_data['base_cost']
	self.max_shots = tower_data['base_max_shots']
	self.fire_speed = tower_data['base_fire_speed']
	self.range = tower_data['base_range'] * ((elevation + 3.1) / 3.1)
	self.attack_type = tower_data['attack_type']
	
	self.bulletType = load("res://Bullets/" + tower_data.get('bullet_type_name', "default") + '.tscn')

	var texture_location = tower_data['texture_location']
	var x = texture_location['x']
	var y = texture_location['y']
	
	var tex = load(texture_location['file_name'])

	self.texture = tex
	self.region_rect = Rect2(x, y, 16,16) 
	
func gain_experience(amount):
	self.level.gain_experience(amount)
	if InputManager.current_selection_tower == self:
		TowerUiManager.update_tower_info_panel(self)

func _set_range(r:float):
	var scale = Vector2(r, r)
	self.area_2d.apply_scale(scale)
