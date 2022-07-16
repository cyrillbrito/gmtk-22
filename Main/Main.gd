extends Node2D

enum StateEnum {rolling, blocked, unblocked}
var gameRound = 1

var wood = 50
var stone = 10
var gem = 0
var mana = 5

export var toolsLevel = 1
export var gameState = StateEnum.unblocked
export var alerts = ['Game Started...']


func _process(delta):
	SetResources()
	SetAlerts()

var random = RandomNumberGenerator.new()
func RollDice():
	var diceValue = random.randi_range(1, 6)
	print(diceValue)
	return diceValue

func NextRound():
	gameRound+=1
	$SideMenu.day = gameRound
	mana += 5

func SetAlerts():
	$alertsLabel.text = ""
	for alert in alerts:
		$alertsLabel.text += alert + '\n'

func AddAlert(newAlert):
	if(alerts.size()>6):
		alerts.remove(0)
	alerts.append(newAlert)
	
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
	
func Buy(_wood, _stone, _gem, _mana, building):
	RemoveResources(_wood, _stone, _gem, _mana)
	if(building != null):
		gameState = StateEnum.blocked
		$Map.placeBuilding(building)


func gatherWood():
	if gameState != StateEnum.unblocked:
		AddAlert('Dice already rolling!')
		return
	if mana < 1:
		AddAlert('You need at least 1 mana')
		return
	gameState = StateEnum.rolling
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	wood += (toolsLevel * 5) + roll
	gameState = StateEnum.unblocked

func gatherStone():
	if gameState != StateEnum.unblocked:
		AddAlert('Dice already rolling!')
		return
	if toolsLevel < 2:
		AddAlert('You need wodden tools to gather stone')
		return
	if mana < 1:
		AddAlert('You need at least 1 mana')
		return
	gameState = StateEnum.rolling
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	wood += ((toolsLevel-1) * 5) + roll
	gameState = StateEnum.unblocked

func gatherGem():
	if gameState != StateEnum.unblocked:
		AddAlert('Dice already rolling!')
		return
	if toolsLevel < 3:
		AddAlert('You need stone tools to gather gems')
		return
	if mana < 1:
		AddAlert('You need at least 1 mana')
		return
	gameState = StateEnum.rolling
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	wood += ((toolsLevel - 2) * 5) + roll
	gameState = StateEnum.unblocked

func FinishGame():
		var endGame = load("res://EndGame/EndGame.tscn").instance()
		self.add_child(endGame)
