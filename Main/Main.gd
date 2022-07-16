extends Node2D

var gameRound = 0
export var resources = [13,11,1,5]

var toolsLevel = 1

func _ready(): 
	SetResources()
	
var random = RandomNumberGenerator.new()
func RollDice():
	var diceValue = random.randi_range(1, 6)
	print(diceValue)
	return diceValue

func goToNextRound():
	gameRound+=1
	resources[3] += RollDice()

func SetResources():
	get_node("SideMenu/MarginContainer/Resources/Wood/Quantity").text = str(resources[0])
	get_node("SideMenu/MarginContainer/Resources/Stone/Quantity").text = str(resources[1])
	get_node("SideMenu/MarginContainer/Resources/Gem/Quantity").text = str(resources[2])
	get_node("SideMenu/MarginContainer/Resources/Mana/Quantity").text = str(resources[3])
