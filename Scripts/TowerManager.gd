extends Node2D

#var base_tower : PackedScene
var tower_data_location := 'res://Data/towers.json'
var tower_datas := {}

func _ready():
	load_tower_data()

func parse_json(text):
	return JSON.parse_string(text)

func read_json_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = parse_json(content_as_text)
	return content_as_dictionary

func load_tower_data():
	var tower_data = read_json_file(tower_data_location)
	for data in tower_data:
		tower_datas[data['name']] = data


