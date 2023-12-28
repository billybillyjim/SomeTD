extends Label

func _ready():
	CurrencyManager.gold_modified.connect(_on_gold_modified.bind())
	self.text = str(CurrencyManager.gold)

func _on_gold_modified():
	self.text = str(CurrencyManager.gold)
