extends Node2D

enum StateEnum {rolling, blocked, unblocked}

var mapMatrix = []
#var OurRandom = preload("OurRandom.gd")

onready var rng = RandomNumberGenerator.new()
onready var tileMap: TileMap = get_node("Buildings")
onready var tileMap2: TileMap = get_node("Buildings2")
onready var tileMap3: TileMap = get_node("Buildings3")
onready var mainNode = get_parent()
onready var shopScene = get_node("/root/Main/SideMenu/MarginContainer/Shop")

var placing
var priceWood
var priceStone
var priceGem
var priceMana
var itemName

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

	# Create empty matrix
	# One bigger than need to avoid errors when acesing
	for x in range(12):
		mapMatrix.append([])
		for y in range(12):
			mapMatrix[x].append('')
	
	# Stage 1 fill
	for x in range(0, 4):
		for y in range(0, 4):
			generate1(x, -y)
	
	# Stage 2
	for x in range(4, 8):
		for y in range(0, 4):
			generate2(x, -y)
	for x in range(4, 8):
		for y in range(4, 8):
			generate2(x, -y)
	for x in range(0, 4):
		for y in range(4, 8):
			generate2(x, -y)

	for x in range(8, 11):
		for y in range(0, 8):
			generate3(x, -y)
	for x in range(8, 11):
		for y in range(8, 11):
			generate3(x, -y)
	for x in range(0, 8):
		for y in range(8, 11):
			generate3(x, -y)

func generate1(x, y):

	if x == 1 && y == -1:
		setMatrix(x, y, 'house')
		return
	
	if (x == 2 && y == -1) || (x == 1 && y == -2):
		setMatrix(x, y, 'road')
		return
	
	var rand = rng.randf()
	
	if rand < .35:
		setMatrix(x, y, 'wood')
		return

func generate2(x, y):

	var rand = rng.randf()
	
	if rand < .15:
		setMatrix(x, y, 'stone')
		return

	if rand < .25:
		setMatrix(x, y, 'wood')
		return

func generate3(x, y):

	var rand = rng.randf()
	
	if rand < .1:
		setMatrix(x, y, 'gem')
		return

	if rand < .2:
		setMatrix(x, y, 'stone')
		return

var typeNumberDict = {
	'house': 19,
	'wood': 12,
	'stone': 13,
	'gem': 14,
	'gather-gem': 15,
	'gather-stone': 16,
	'gather-wood': 17,
	'workshop': 18,
	'road': 8,
	'castle': 20,
}

func setMatrix(x, y, type):
	var number = typeNumberDict[type]
	tileMap.set_cell(x, y, number)
	mapMatrix[x][y] = type
	tileMap.update_bitmask_region()


func countAround(v, types):
	var around = [
		mapMatrix[v.x-1][v.y],
		mapMatrix[v.x+1][v.y],
		mapMatrix[v.x][v.y-1],
		mapMatrix[v.x][v.y+1],
	]
	var count = 0
	for tile in around:
		if tile in types:
			count += 1
	return count

func canBuild(v):
	var validConnections = [
		'road',
		'house',
		'gather-wood',
		'gather-stone',
		'gather-gem',
		'workshop',
		'castle',
	]
	return 0 < countAround(v, validConnections)

func _input(event):
	
	if (event is InputEventKey && event.pressed and event.scancode == KEY_ESCAPE) || (event is InputEventMouseButton and event.button_index == BUTTON_MASK_RIGHT and event.is_pressed()):
		mainNode.AddAlert('Placing cancelled.')
		cancelPlacement()
		return

	if !(event is InputEventMouseButton) && !(event is InputEventMouseMotion):
		return

	var mousePos = tileMap.world_to_map(tileMap.to_local(event.position))
	if mousePos.x < 0 || mousePos.x > 10 || mousePos.y < -10 || mousePos.y > 0:
		return

	tileMap2.clear()
	tileMap3.clear()

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		mouseClick(mousePos)
	elif event is InputEventMouseMotion:
		mouseMove(mousePos)

func cancelPlacement():
	placing = null
	priceWood = null
	priceStone = null
	priceGem = null
	priceMana = null
	mainNode.gameState = StateEnum.unblocked

func mouseClick(mousePos: Vector2):
	
	if placing:
		if placing == 'castle' && (mousePos.x < 8 && mousePos.y > -8):
			mainNode.AddAlert('The castle can only be built on the desert.')
		elif canBuild(mousePos):
			if placing == 'castle':
				mainNode.FinishGame(true)
			setMatrix(mousePos.x, mousePos.y, placing)
			mainNode.RemoveResources(priceWood, priceStone, priceGem, priceMana)
			mainNode.AddAlert("Bought " + itemName)
			shopScene.UpdateShop(itemName)
			$BuildAudio.play()
			mainNode.gameState = StateEnum.unblocked
			cancelPlacement()
			
		else:
			mainNode.AddAlert('Buildings and roads need to be next to other buildings or roads')
		return

	# Normal mouse moving
	if mapMatrix[mousePos.x][mousePos.y] == 'wood':
		mainNode.gatherWood()
	elif mapMatrix[mousePos.x][mousePos.y] == 'stone':
		mainNode.gatherStone()
	elif mapMatrix[mousePos.x][mousePos.y] == 'gem':
		mainNode.gatherGem()

func mouseMove(mousePos: Vector2):
	var cell
	if placing:
		tileMap3.set_cellv(mousePos, typeNumberDict[placing])
	else:
		cell = tileMap.get_cellv(mousePos)
		if cell in [12, 13, 14]:
			tileMap2.set_cellv(mousePos, cell)

func placeBuilding(building, _wood, _stone, _gem, _mana, name):
	mainNode.AddAlert("Place " + name)
	placing = building
	priceWood = _wood
	priceStone = _stone
	priceGem = _gem
	priceMana = _mana
	itemName = name
