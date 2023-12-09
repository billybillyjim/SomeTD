extends Panel

func toggle_panel():
	self.visible = !self.visible
	get_tree().paused = self.visible

