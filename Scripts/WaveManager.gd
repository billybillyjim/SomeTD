extends Node

var wave_data_location := 'res://Data/waves.json'
var wave_datas := {}

static var current_wave := 0


func _ready():
	load_wave_data()

func parse_json(text):
	return JSON.parse_string(text)

func read_json_file(file_path):
	var file = FileAccess.open(file_path, FileAccess.READ)
	var content_as_text = file.get_as_text()
	var content_as_dictionary = parse_json(content_as_text)
	return content_as_dictionary

func load_wave_data():
	var wave_data = read_json_file(wave_data_location)
	for data in wave_data:
		wave_datas[data['level_name']] = data
