extends MarginContainer

enum StateEnum {rolling, blocked, unblocked}
onready var mainNode = get_parent()
onready var colorRect = get_node("ColorRect")
onready var dayLabel = get_node("MarginContainer/DayLabel")
export var day = 1;

func _process(delta):
	if mainNode.gameState == StateEnum.unblocked:
		colorRect.visible = false
	else: colorRect.visible = true
#	print("Day "+ str(day) +" / 10")
	dayLabel.text = "Day "+ str(day) +" / 10"

func _on_NextRoundBtn_pressed():
	mainNode.NextRound()
	print("NextDay")
