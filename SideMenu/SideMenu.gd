extends MarginContainer

enum StateEnum {rolling, blocked, unblocked}
onready var mainNode = get_parent()
onready var dayLabel = get_node("MarginContainer/DayLabel")
export var maxDays: int;
export var day = 1;

func _process(delta):
	if mainNode.gameState == StateEnum.unblocked:
		$ColorRect.visible = false
	else: $ColorRect.visible = true
	dayLabel.text = "Day "+ str(day) +" / " + str(maxDays) 

func _on_NextRoundBtn_pressed():
	mainNode.NextRound()
	mainNode.AddAlert("New Day")
