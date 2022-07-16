extends HBoxContainer

signal result

var random = RandomNumberGenerator.new()
onready var mainNode = get_node("/root/Main")

func _ready():
	random.randomize()

func roll():
	var diceValue = random.randi_range(1, 6)
	mainNode.AddAlert('Rolling Dice...')
	yield(get_tree().create_timer(2), "timeout")
	mainNode.AddAlert('Rolled a ' + str(diceValue))
	return diceValue
