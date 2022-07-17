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
	get_node("SideMenu/MarginContainer/Resourses/Resources/Wood/Quantity").text = str(wood)
	get_node("SideMenu/MarginContainer/Resourses/Resources/Stone/Quantity").text = str(stone)
	get_node("SideMenu/MarginContainer/Resourses/Resources/Gem/Quantity").text = str(gem)
	get_node("SideMenu/MarginContainer/Resourses/Resources/Mana/Quantity").text = str(mana)
	
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


func gatherWood(multiplier = 1):
	wood += yield(preGather(1, multiplier), 'completed')

func gatherStone(multiplier = 1):
	stone += yield(preGather(2, multiplier), 'completed')

func gatherGem(multiplier = 1):
	gem += yield(preGather(3, multiplier), 'completed')

func preGather(reqTool, multiplier):
	if gameState != StateEnum.unblocked:
		AddAlert('Dice already rolling!')
		return 0

	if toolsLevel < reqTool:
		AddAlert('You need to upgrade your tools to gather this resource.')
		return 0

	if mana < 1:
		AddAlert('You need at least 1 mana.')
		return 0

	gameState = StateEnum.rolling
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	gameState = StateEnum.unblocked
	return ((toolsLevel + 1 - reqTool) * 5) * multiplier + roll

func FinishGame():
		var endGame = load("res://EndGame/EndGame.tscn").instance()
		self.add_child(endGame)
