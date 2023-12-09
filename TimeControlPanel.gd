extends Control

@onready var play_button = $MarginContainer/HBoxContainer/Control/Play
@onready var double_button = $MarginContainer/HBoxContainer/Control2/Double
@onready var triple_button = $MarginContainer/HBoxContainer/Control3/Triple
@onready var quintuple_button = $MarginContainer/HBoxContainer/Control4/Quintuple
@onready var icon_atlas = preload("res://miniworld/User Interface/UiIcons2.png")

func set_time(rate):
	if rate == TimeManager.play_speed and not get_tree().paused:
		get_tree().paused = true
	else:
		get_tree().paused = false
	
	set_button_texture(rate)
	
	if get_tree().paused:
		set_play_button_texture("Pause")
	elif rate == 1:
		set_play_button_texture("Play")
	
	

	TimeManager.play_speed = rate	
	
func set_button_texture(rate):
	play_button.texture_normal.region = Rect2(0,32,16,16)
	double_button.texture_normal.region = Rect2(32,32,16,16)
	triple_button.texture_normal.region = Rect2(48,32,16,16)
	quintuple_button.texture_normal.region = Rect2(48,48,16,16)
	if rate == 2:
		double_button.texture_normal.region = Rect2(32,64,16,16)
	elif rate == 3:
		triple_button.texture_normal.region = Rect2(48,64,16,16)
	elif rate == 5:
		quintuple_button.texture_normal.region = Rect2(48,80,16,16)
	
func set_play_button_texture(button):
	var atlas = AtlasTexture.new()
	atlas.atlas = icon_atlas
	
	if button == "Play":
		atlas.region = Rect2(0, 64, 16, 16)
	elif button == "Pause":
		atlas.region = Rect2(16, 64, 16, 16)
	else:
		print("Invalid button name")
		print(button)
	play_button.texture_normal = atlas
	


func _on_texture_button_pressed(rate):
	set_time(rate)
