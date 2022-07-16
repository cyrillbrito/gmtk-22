extends Node2D

var gameRound = 0

var wood = 0
var stone = 0
var gem = 0
var mana = 5

var toolsLevel = 1

var rolling = false

func _process(delta):
	SetResources()

var random = RandomNumberGenerator.new()
func RollDice():
	var diceValue = random.randi_range(1, 6)
	print(diceValue)
	return diceValue

func goToNextRound():
	gameRound+=1
	mana += 5

func SetResources():
	get_node("SideMenu/MarginContainer/Resources/Wood/Quantity").text = str(wood)
	get_node("SideMenu/MarginContainer/Resources/Stone/Quantity").text = str(stone)
	get_node("SideMenu/MarginContainer/Resources/Gem/Quantity").text = str(gem)
	get_node("SideMenu/MarginContainer/Resources/Mana/Quantity").text = str(mana)
	
func RemoveResources(_wood, _stone, _gem, _mana):
	wood -= _wood
	stone -= _stone
	gem -= _gem
	mana -= _mana
	
func CanBuy(_wood, _stone, _gem, _mana):
	return wood >= _wood && stone >= _stone && gem >= _gem  && mana >= _mana
	


func gatherWood():
	if rolling:
		print('Dice already rolling')
		return
	if mana < 1:
		print('You need at least 1 mana')
		return
	rolling = true
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	wood += (toolsLevel * 5) + roll
	rolling = false



func gatherStone():
	if rolling:
		print('Dice already rolling!')
		return
	if toolsLevel < 2:
		print('You need wodden tools to gather stone')
		return
	if mana < 1:
		print('You need at least 1 mana')
		return
	rolling = true
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	wood += ((toolsLevel-1) * 5) + roll
	rolling = false



func gatherGem():
	if rolling:
		print('Dice already rolling!')
		return
	if toolsLevel < 3:
		print('You need stone tools to gather gems')
		return
	if mana < 1:
		print('You need at least 1 mana')
		return
	rolling = true
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	wood += ((toolsLevel - 2) * 5) + roll
	rolling = false
