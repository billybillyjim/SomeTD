extends Panel

@onready var main_menu = $MainMenu
@onready var level_menu = $LevelMenu

func show_level_menu():
	main_menu.visible = false
	level_menu.visible = true

func show_main_menu():
	main_menu.visible = true
	level_menu.visible = false
