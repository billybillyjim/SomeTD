extends Panel

@onready var sprite_2d = $HBoxContainer/LevelIcon/Sprite2D
@onready var level_name = $HBoxContainer/Control/LevelName
@onready var grid_container = $HBoxContainer/EnemyDescription/MarginContainer/GridContainer
@onready var enter_button = $HBoxContainer/EnterButton
@onready var main = $/root/Main/MapParent
@export var enemy_preview_cell : PackedScene

func apply_level_data(texture, lv_name, enemies, file_name):
	sprite_2d.texture = texture
	level_name.text = lv_name
	for enemy in enemies:
		var cell = enemy_preview_cell.instantiate()
		cell.get_child(0).texture = enemy.atlas
		grid_container.add_child(cell)
	enter_button.pressed.connect(load_level.bind(file_name, lv_name))
	
	
func load_level(file_name, lv_name):
	var level = load(file_name).instantiate()
	for child in main.get_children():
		child.queue_free()
	main.add_child(level)
	TowerUiManager.set_up_level_menus()
	LevelManager.current_level = lv_name
	LevelManager.current_level_file_name = file_name
