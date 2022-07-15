extends Node2D
var random = RandomNumberGenerator.new()
var gameRound = 0

var stone = 0
var wood = 0
var mana = 0
var gemStone = 0

# Called when the node enters the scene tree for the first time.
func _ready(): 
	pass


func _on_RollDiceBtn_pressed():
	gameRound+=1
	var diceValue = random.randi_range(1, 6)
	print(diceValue)
	mana += diceValue
