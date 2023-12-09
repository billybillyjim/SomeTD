extends TileMap
class_name InputManager

@export var selection_box :PackedScene
@export var base_tower :PackedScene
@onready var towerParent = $"Towers"
@onready var enemies = $Enemies

@onready var main = $/root/Main/MapParent

static var current_selection_box
static var current_selection_tower
var CELL_SIZE = 16
var OFFSET = 8

var used_tiles := {}

func position_snapped(pos:Vector2):
	return (pos / CELL_SIZE).floor() * CELL_SIZE + Vector2(OFFSET, OFFSET)
	
func clear_selection_box():
	if current_selection_box != null:
		current_selection_box.queue_free()
	
func _unhandled_input (event):
	if event is InputEventMouseButton:
		var pos = event.position
		if event.pressed:
			clear_selection_box()
			var tile_pos = self.local_to_map(self.get_local_mouse_position())

			var elevated_cell = self.get_cell_tile_data(1, tile_pos)
			var data = self.get_cell_tile_data(0, tile_pos)

			var cell = self.get_cell_tile_data(0, tile_pos)
			var placeable = true
			if elevated_cell != null:
				placeable = elevated_cell.get_custom_data('Placeable')
				if not placeable:
					return
			if cell != null:
				placeable = cell.get_custom_data('Placeable')
				if not placeable:
					return
					
			current_selection_box = selection_box.instantiate()
			self.add_child(current_selection_box)
			current_selection_box.position = position_snapped(self.get_global_mouse_position())
			if used_tiles.has(current_selection_box.position):
				current_selection_tower = used_tiles[current_selection_box.position]
				set_selected_tower_info()
				
			else:
				current_selection_tower = null
				TowerUiManager.set_active_panel(TowerUiManager.panel_type.TOWERS)
				
			if elevated_cell != null:
				current_selection_box.z_index = 2
			

func begin_wave():
	var wave = WaveManager.wave_datas[LevelManager.current_level][WaveManager.current_wave]
	
	for child in get_children():
		if child.has_method("spawn_wave"):
			child.spawn_wave(wave)

func _on_button_pressed(tower_name):
	if current_selection_box != null and not used_tiles.has(current_selection_box.position):
		var new_tower = base_tower.instantiate()
		towerParent.add_child(new_tower)
		new_tower.set_values(tower_name, current_selection_box.z_index)
		new_tower.position = current_selection_box.position
		current_selection_tower = new_tower
		set_selected_tower_info()
		used_tiles[new_tower.position] = new_tower
		
func upgrade_tower(tower, upgrade_name, cost):
	if CurrencyManager.pay_gold(cost):
		var old_exp = tower.level.get_experience()
		tower.set_values(upgrade_name, current_selection_box.z_index)
		tower.level.load_experience(old_exp)
		current_selection_tower = tower
		set_selected_tower_info()
		used_tiles[tower.position] = tower

func set_selected_tower_info():
	TowerUiManager.set_active_panel(TowerUiManager.panel_type.SELECTED_TOWER)
	var progress = current_selection_tower.level.get_progress()
	var level = current_selection_tower.level.get_skill_level()
	TowerUiManager.set_up_tower_info_panel(current_selection_tower)
	

