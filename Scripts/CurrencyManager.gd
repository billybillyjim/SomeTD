extends Node

static var gold := 10
static var base_lives := 10
static var current_lives := 10

signal gold_modified
signal lives_modified

func reset_lives():
	current_lives = base_lives

func set_lives(amount):
	current_lives = amount

func add_lives(amount):
	current_lives += amount
	lives_modified.emit()
	
func remove_lives(amount):
	current_lives -= amount
	lives_modified.emit()	

func add_gold(amount):
	gold += amount
	gold_modified.emit()
	
func pay_gold(amount):
	if gold < amount:
		return false
	
	gold -= amount
	gold_modified.emit()
	return true
