extends Node2D

enum StateEnum {rolling, blocked, unblocked}
var gameRound = 1

var wood = 50
var stone = 10
var gem = 10
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
	
func Buy(_wood, _stone, _gem, _mana, building, itemName):
	if(building != null):
		gameState = StateEnum.blocked
		$Map.placeBuilding(building, _wood, _stone, _gem, _mana, itemName)
	else: 
		RemoveResources(_wood, _stone, _gem, _mana)


func gatherWood():
	var arr = yield(preGather(1), 'completed')
	if arr:
		wood += arr[0] + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' wood manually, plus ' + str(arr[1]) + ' from the roll')

func gatherStone():
	var arr = yield(preGather(2), 'completed')
	if arr:
		wood += arr[0] + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' wood manually, plus ' + str(arr[1]) + ' from the roll')

func gatherGem():
	var arr = yield(preGather(3), 'completed')
	AddAlert('You collected ' + str(arr[0]) + ' wood manually, plus ' + str(arr[1]) + ' from the roll')
	if arr:
		wood += arr[0] + arr[1]

func gatherHarvesterWood(multiplier):
	var arr = yield(preGather(1), 'completed')
	if arr:
		wood += arr[0] * multiplier + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' * ' + str(multiplier) + ' wood from the harvester, plus ' + str(arr[1]) + ' from the roll')

func gatherHarvesterStone(multiplier):
	var arr = yield(preGather(2), 'completed')
	if arr:
		stone += arr[0] * multiplier + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' * ' + str(multiplier) + ' stone from the harvester, plus ' + str(arr[1]) + ' from the roll')

func gatherHarvesterGem(multiplier):
	var arr = yield(preGather(3), 'completed')
	if arr:
		gem += arr[0] * multiplier + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' * ' + str(multiplier) + ' gems from the harvester, plus ' + str(arr[1]) + ' from the roll')

func preGather(reqTool):
	if gameState != StateEnum.unblocked:
		AddAlert('Dice already rolling!')
		yield()
		return 0

	if toolsLevel < reqTool:
		AddAlert('You need to upgrade your tools to gather this resource.')
		yield()
		return 0

	if mana < 1:
		AddAlert('You need at least 1 mana.')
		yield()
		return 0

	gameState = StateEnum.rolling
	mana -= 1
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	gameState = StateEnum.unblocked
	var baseValue = (toolsLevel + 1 - reqTool) * 5;
	return [baseValue, roll]


func FinishGame():
		var endGame = load("res://EndGame/EndGame.tscn").instance()
		self.add_child(endGame)
