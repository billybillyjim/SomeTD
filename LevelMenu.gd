extends Control

var level_list_item_panel = preload("res://Scenes/level_list_item_panel.tscn")
@onready var panel_instance_parent = $MarginContainer/VBoxContainer

func _ready():
	load_levels()

func load_levels():
	for level in LevelManager.level_datas:
		var data = LevelManager.level_datas[level]
		var texture = load(data['level_icon']['icon'])
		var enemies = []
		for e in data['enemies']:
			var enemy_texture = load(e['icon'])
				
			var atlas = AtlasTexture.new()
			atlas.atlas = enemy_texture

			atlas.region = Rect2(e['x'], e['y'], 16, 16)
			enemies.append(atlas)
		var panel_instance = level_list_item_panel.instantiate()
		panel_instance_parent.add_child(panel_instance)
		panel_instance.apply_level_data(texture, level, enemies, data['file_name'])


func enter_level(file_name):
	pass
	
