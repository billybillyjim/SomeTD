extends Panel

@onready var main = $/root/Main/MapParent

func toggle_panel():
	self.visible = !self.visible
	get_tree().paused = self.visible


func quit_level():
	print('quitting')
	for child in main.get_children():
		child.queue_free()
	LevelManager.current_level = ''
	TowerUiManager.tear_down_level_menus()
	if self.visible:
		toggle_panel()
	
func restart_level():
	print('restsartoing')
	var level = load(LevelManager.current_level_file_name).instantiate()
	for child in main.get_children():
		child.queue_free()
	main.add_child(level)
	TowerUiManager.set_up_level_menus()
	if self.visible:
		toggle_panel()

func _on_quit_button_pressed():
	quit_level()

func _on_reset_button_pressed():
	restart_level()
