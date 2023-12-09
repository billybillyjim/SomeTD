extends HBoxContainer

@onready var tower_info_label = $Panel/TowerInfoLabel

@onready var exp_progress_label = $Panel/MarginContainer/VBoxContainer/EXPPanel/VBox/Parent/EXPProgressLabel
@onready var exp_progress = $Panel/MarginContainer/VBoxContainer/EXPPanel/VBox/Parent/EXPProgress
@onready var level_label = $Panel/MarginContainer/VBoxContainer/EXPPanel/LevelLabel

@onready var fire_speed_value = $"Panel/MarginContainer/VBoxContainer/StatsPanel/VBoxContainer/FireSpeedPanel/MarginContainer/HSplitContainer/Fire Speed Value"
@onready var max_shots_value = $"Panel/MarginContainer/VBoxContainer/StatsPanel/VBoxContainer/MaxShotsPanel/MarginContainer/HSplitContainer/Max Shots Value"
@onready var range_value = $"Panel/MarginContainer/VBoxContainer/StatsPanel/VBoxContainer/MaxShotsPanel2/MarginContainer/HSplitContainer/Range Value"
@onready var damage_value = $"Panel/MarginContainer/VBoxContainer/StatsPanel/VBoxContainer/MaxShotsPanel3/MarginContainer/HSplitContainer/Damage Value"
@onready var attack_style_value = $"Panel/MarginContainer/VBoxContainer/StatsPanel/VBoxContainer/MaxShotsPanel4/MarginContainer/HSplitContainer/Attack Style Value"

@onready var upgrades_grid = $Panel/MarginContainer/VBoxContainer/UpgradesPanel/MarginContainer/Upgrades/GridContainer

var upgrade_button = preload("res://upgrade_button.tscn")
var regex = RegEx.new()

func sell_tower(tower):
	CurrencyManager.add_gold(tower.base_cost * 0.75)
	
func update_buttons(tower):
	for i in upgrades_grid.get_children():
		i.queue_free()
		
	if tower != null:
		var upgrades = TowerManager.tower_datas[tower.title].get('upgrades', [])
		for u in upgrades:
			make_upgrade_button(tower, TowerManager.tower_datas[u['tower_name']])

func update_values(tower):
	fire_speed_value.text = ("%.2f" % tower.fire_speed)
	max_shots_value.text = ("%.2f" % tower.max_shots)
	range_value.text = ("%.2f" % tower.range)
	damage_value.text = ("%.2f" % tower.damage)
	attack_style_value.text = tower.attack_type
	level_label.text = 'Level ' + str(tower.level.get_skill_level())
	exp_progress_label.text = ("%.2f" % tower.level.get_progress()) + '%'
	exp_progress.value = tower.level.get_progress()
	tower_info_label.text = tower.title
	
	regex.compile("(\\d*)")
	for ug_button in upgrades_grid.get_children():
		if ug_button.get_child_count() > 0:
			var cost = int(regex.search(ug_button.get_child(0).text).get_string())
			if CurrencyManager.gold < cost:
				ug_button.modulate = Color(1.0,1.0,1.0,0.5)
				ug_button.disabled = true
			else:
				ug_button.modulate = Color(1.0,1.0,1.0,1.0)
				ug_button.disabled = false

func make_upgrade_button(tower, upgrade):
	var tile_map = $"../../MapParent/TileMap"
	var instance = upgrade_button.instantiate()
	var tex = load(upgrade.texture_location['file_name'])
	
	var atlas = AtlasTexture.new()
	atlas.atlas = tex
	
	var x = upgrade.texture_location['x']
	var y = upgrade.texture_location['y']
	
	atlas.region = Rect2(x, y, 16, 16)
	
	instance.texture_normal = atlas
	instance.pressed.connect(tile_map.upgrade_tower.bind(tower, upgrade.title, upgrade.base_cost))
	instance.get_child(0).text = "$" + str(upgrade.base_cost)
	if CurrencyManager.gold < upgrade.base_cost:
		instance.disabled = true
		instance.modulate = Color(1.0,1.0,1.0,0.5)
	upgrades_grid.add_child(instance)

