extends Node

static var gold := 10

signal gold_modified

func add_gold(amount):
	gold += amount
	gold_modified.emit()
	
func pay_gold(amount):
	if gold < amount:
		return false
	
	gold -= amount
	gold_modified.emit()
	return true
