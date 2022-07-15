extends Node2D
var gameRound = 0

var wood = 0
var stone = 0
var gem = 0
var mana = 0

func _ready(): 
	pass

##This Logic will probaily go to SideMenu
var random = RandomNumberGenerator.new()
func RollDice():
	var diceValue = random.randi_range(1, 6)
	print(diceValue)
	return diceValue

##This Logic will probaily go to SideMenu
func _on_NextRoundBtn_pressed():
	gameRound+=1
	mana += RollDice()
