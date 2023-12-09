extends Sprite2D

@onready var area_2d = $Area2D

var target := Node2D
var speed := 50
var life_time := 5
var lived_time := 0.0
var tower : Node2D
var dead = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta = delta * TimeManager.play_speed
	lived_time += delta
	if lived_time >= life_time:
		if tower != null:
			tower.current_shots -= 1
		self.queue_free()
	if target != null:
		self.global_position = self.global_position.move_toward(target.global_position, speed * delta)
	for area in area_2d.get_overlapping_areas():
		if area.get_parent() != null:
			var enemy = area.get_parent()
			
			if not enemy or not enemy.has_method("take_damage"):
				continue
			
			enemy.take_damage(tower.damage)
			
			if tower != null and not dead:
				tower.gain_experience(tower.damage)
				tower.current_shots -= 1
				dead = true
			self.queue_free()

