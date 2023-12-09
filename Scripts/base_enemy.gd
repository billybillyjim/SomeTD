extends Sprite2D
class_name base_enemy

var tile_map : TileMap

var goal : Node2D

var path :PackedVector2Array
var speed := 50
var hitpoints := 3
var worth := 1
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().process_frame
	find_path()
	

func find_path():
	if goal == null:
		get_parent().remove_child(self)
		return
	var tile_map_rid: RID = tile_map.get_navigation_map(0)
	var start_position: Vector2 = position
	var target_position: Vector2 = goal.position
	path = NavigationServer2D.map_get_path(
		tile_map_rid,
		start_position,
		target_position,
		true
	)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	delta = delta * TimeManager.play_speed
	if hitpoints <= 0:
		CurrencyManager.add_gold(worth)
		self.queue_free()
	if len(path) > 0:	
		self.position = self.position.move_toward(path[0], delta * speed)
		if self.position.is_equal_approx(path[0]):
			path.remove_at(0)
	else:
		self.queue_free()

func take_damage(amount):
	hitpoints -= amount
