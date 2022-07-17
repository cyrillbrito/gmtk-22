extends HBoxContainer

signal result

var random = RandomNumberGenerator.new()
onready var mainNode = get_node("/root/Main")

func _ready():
	random.randomize()

func roll():
	$DiceRollAudio.play()
	mainNode.AddAlert('Rolling Dice...')

	var diceValue
	for i in range(9):
		var newVal = UniqueRool()
		while diceValue == newVal:
			newVal = UniqueRool()
		diceValue = newVal
		yield(get_tree().create_timer(.2), "timeout")

	return diceValue

func UniqueRool():
	var diceValue = random.randi_range(1, 6)
	SetDiceUi(diceValue)
	return diceValue

func SetDiceUi(number):
	$Dice.texture = load('res://assets/Dice/Dice'+str(number)+'.png')
