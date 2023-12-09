extends Node

var level_data_location := 'res://Data/levels.json'
var level_datas := {}
static var current_level := ''
static var current_level_file_name := ''

func _ready():
	load_level_data()

func parse_json(text):
	return JSON.parse_string(text)

func read_json_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = parse_json(content_as_text)
	return content_as_dictionary

func load_level_data():
	var level_data = read_json_file(level_data_location)
	for data in level_data:
		level_datas[data['level_name']] = data

