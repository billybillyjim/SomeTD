extends HBoxContainer

@onready var tower_button = preload("res://Scenes/tower_button.tscn")
@onready var button_parent = $Panel/MarginContainer/GridContainer

func add_button(tower_info):
	var tile_map = $"../../MapParent/TileMap"
	var instance = tower_button.instantiate()
	var tex = load(tower_info['texture_location']['file_name'])
	
	var atlas = AtlasTexture.new()
	atlas.atlas = tex
	
	var x = tower_info['texture_location']['x']
	var y = tower_info['texture_location']['y']

	atlas.region = Rect2(x, y, 16, 16)
	
	instance.get_child(0).texture = atlas
	instance.pressed.connect(tile_map._on_button_pressed.bind(tower_info['name']))
	button_parent.add_child(instance)

	
func set_up_panel():
	for child in button_parent.get_children():
		child.queue_free()
		
	for tower in TowerManager.tower_datas:
		if TowerManager.tower_datas[tower]['is_base_tower']:
			add_button(TowerManager.tower_datas[tower])
