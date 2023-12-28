extends Label

func _ready():
	CurrencyManager.lives_modified.connect(_on_lives_modified.bind())
	self.text = str(CurrencyManager.current_lives)

func _on_lives_modified():
	self.text = str(CurrencyManager.current_lives)
