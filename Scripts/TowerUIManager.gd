extends CanvasLayer

static var tower_panel
static var tower_info_panel
static var main_menu_panel
static var currency_panel
static var time_control_panel
enum panel_type {TOWERS, SELECTED_TOWER}

func _ready():
	tower_panel = $/root/Main/MainUI/TowerPanel
	tower_info_panel = $/root/Main/MainUI/TowerInfoPanel
	main_menu_panel = $/root/Main/MainUI/MainMenuPanel
	currency_panel = $/root/Main/MainUI/CurrencyPanel
	time_control_panel = $/root/Main/MainUI/TimeControlPanel

static func set_active_panel(panel_name):
	if panel_name == panel_type.TOWERS:
		tower_panel.visible = true
		tower_info_panel.visible = false
	elif panel_name == panel_type.SELECTED_TOWER:
		tower_panel.visible = false
		tower_info_panel.visible = true
		
static func set_up_level_menus():
	hide_main_menu()
	currency_panel.visible = true
	time_control_panel.visible = true
	set_active_panel(panel_type.TOWERS)
	tower_panel.set_up_panel()
	
static func tear_down_level_menus():
	show_main_menu()
	time_control_panel.visible = false
	currency_panel.visible = false
	hide_tower_panels()
	
static func hide_tower_panels():
	tower_panel.visible = false
	tower_info_panel.visible = false
	
static func show_main_menu():
	main_menu_panel.visible = true
		
static func hide_main_menu():
	main_menu_panel.visible = false

static func set_up_tower_info_panel(tower):
	tower_info_panel.update_values(tower)
	tower_info_panel.update_buttons(tower)
	
static func update_tower_info_panel(tower):
	tower_info_panel.update_values(tower)
