extends Panel


func toggle_panel():
	self.visible = !self.visible
	get_tree().paused = self.visible


func quit_level():
	LevelManager.end_level()
	if self.visible:
		toggle_panel()
	
func restart_level():
	LevelManager.restart_level()
	if self.visible:
		toggle_panel()
		
func show_end_of_level_panel():
	return

func _on_quit_button_pressed():
	quit_level()

func _on_reset_button_pressed():
	restart_level()
