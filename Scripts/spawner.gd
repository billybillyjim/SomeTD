extends Node2D


@export var spawn_rate: float = 0.1
@export var amount_to_spawn := 12000
@export var spawnee: PackedScene
@onready var enemyParent = $"../Enemies"
@onready var goal = $"../Goal"
@onready var tile_map = $".."

var timer: Timer = Timer.new()
var spawned_objects := 0

func _ready():
	add_child(timer)
	timer.connect("timeout", _on_timer_timeout)
	timer.wait_time = spawn_rate / TimeManager.play_speed
	timer.start()

func spawn_wave(enemy_to_spawn, amount, rate):
	self.spawnee = enemy_to_spawn
	self.amount_to_spawn = amount
	self.spawn_rate = rate
	timer.wait_time = spawn_rate / TimeManager.play_speed
	timer.start()

func _on_timer_timeout():
	if spawned_objects < amount_to_spawn:
		if spawnee != null:
			var new_object = spawnee.instantiate()
			new_object.goal = goal
			new_object.tile_map = tile_map
			
			enemyParent.add_child(new_object)
			new_object.position = self.position
			spawned_objects += 1
			timer.wait_time = spawn_rate / TimeManager.play_speed
