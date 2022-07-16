extends MarginContainer

enum StateEnum {rolling, blocked, unblocked}
onready var mainNode = get_parent()
onready var colorRect = get_node("ColorRect")

func _process(delta):
	if mainNode.gameState == StateEnum.unblocked:
		colorRect.visible = false
	else: colorRect.visible = true

func _on_NextRoundBtn_pressed():
	var MainScene = get_parent()
	MainScene.goToNextRound()
