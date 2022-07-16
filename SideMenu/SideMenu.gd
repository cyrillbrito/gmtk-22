extends MarginContainer


func _ready():
	pass
#	SetResources()
#
#func SetResources():
#	get_node("MarginContainer/Resources/Wood/Quantity").text = str(resources[0])
#	get_node("MarginContainer/Resources/Stone/Quantity").text = str(resources[1])
#	get_node("MarginContainer/Resources/Gem/Quantity").text = str(resources[2])
#	get_node("MarginContainer/Resources/Mana/Quantity").text = str(resources[3])

func _on_NextRoundBtn_pressed():
	var MainScene = get_parent()
	MainScene.goToNextRound()
