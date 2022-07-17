extends Node2D

enum StateEnum {rolling, blocked, unblocked}
var gameRound = 1
var maxRounds = 10

var wood = 0
var stone = 0
var gem = 0
var mana = 4

export var toolsLevel = 1
export var gameState = StateEnum.unblocked
export var alerts = ['Game Started...']


var goDark = false
var currColor = 1

func _ready():
	$SideMenu.maxDays = maxRounds
	

func _process(delta):
	SetResources()
	SetAlerts()
	
	if goDark:
		currColor -= delta
	elif currColor < 1:
		currColor += delta
	else :
		currColor = 1
	modulate = Color(currColor, currColor, currColor)

func NextRound():
	if maxRounds == gameRound:
		FinishGame(false)
		return
	
	goDark = true
	yield(get_tree().create_timer(.7), "timeout")
	goDark = false
	yield(get_tree().create_timer(.7), "timeout")
	
	gameRound+=1
	$SideMenu.day = gameRound
	mana = 4
	
	for x in range(11):
		var row = $Map.mapMatrix[x]
		for y in range(11):
			var cell = row[-y]
			if cell == 'gather-wood':
				var mult = $Map.countAround(Vector2(x, -y), ['wood'])
				yield(gatherHarvesterWood(mult), 'completed')
			elif cell == 'gather-stone':
				var mult = $Map.countAround(Vector2(x, -y), ['stone'])
				yield(gatherHarvesterStone(mult), 'completed')
			elif cell == 'gather-gem':
				var mult = $Map.countAround(Vector2(x, -y), ['gem'])
				yield(gatherHarvesterGem(mult), 'completed')


func SetAlerts():
	$alertsLabel.text = ""
	for alert in alerts:
		$alertsLabel.text += alert + '\n'

func AddAlert(newAlert):
	if(alerts.size()>6):
		alerts.remove(0)
	alerts.append(newAlert)

func AddWarningAlert(newAlert):
	$ErrorAudio.play()
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
	if(building != ""):
		gameState = StateEnum.blocked
		$Map.placeBuilding(building, _wood, _stone, _gem, _mana, itemName)
	else: 
		RemoveResources(_wood, _stone, _gem, _mana)


func gatherWood():
	var arr = yield(preGather(1), 'completed')
	if arr:
		mana -= 1
		wood += arr[0] + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' wood manually, plus ' + str(arr[1]) + ' from the roll')

func gatherStone():
	var arr = yield(preGather(2), 'completed')
	if arr:
		mana -= 1
		stone += arr[0] + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' stone manually, plus ' + str(arr[1]) + ' from the roll')

func gatherGem():
	var arr = yield(preGather(3), 'completed')
	if arr:
		mana -= 1
		gem += arr[0] + arr[1]
		AddAlert('You collected ' + str(arr[0]) + ' gem manually, plus ' + str(arr[1]) + ' from the roll')

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
		AddWarningAlert('Dice already rolling!')
		yield()
		return 0

	if toolsLevel < reqTool:
		$ErrorAudio.play()
		AddWarningAlert('You need to upgrade your tools to gather this resource.')
		yield()
		return 0

	if mana < 1:
		$ErrorAudio.play()
		AddWarningAlert('You need at least 1 mana.')
		yield()
		return 0

	gameState = StateEnum.rolling
	var dice = get_node("SideMenu/MarginContainer/Dice")
	var roll = yield(dice.roll(), 'completed')
	gameState = StateEnum.unblocked
	var baseValue = (toolsLevel + 1 - reqTool) * 5;
	return [baseValue, roll]


func FinishGame(won):
	var endGame = load("res://EndGame/EndGame.tscn").instance()
	if won:
		endGame.wonInTurns = gameRound
	add_child(endGame)
	move_child(endGame, 100)
