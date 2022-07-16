extends MarginContainer

func _ready():
	pass

func _on_NextRoundBtn_pressed():
	var MainScene = get_parent()
	MainScene.goToNextRound()
