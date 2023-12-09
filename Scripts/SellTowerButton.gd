extends Button

@onready var upgrades = $"../../MarginContainer/Upgrades"
@onready var sell = $"../../MarginContainer/Sell"

func toggle_sell_panel():
	upgrades.visible = sell.visible
	sell.visible = !sell.visible


func _on_pressed():
	toggle_sell_panel()
