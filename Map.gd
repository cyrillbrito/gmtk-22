extends Node2D

enum StateEnum {rolling, blocked, unblocked}

var mapMatrix = []
#var OurRandom = preload("OurRandom.gd")

onready var rng = RandomNumberGenerator.new()
onready var tileMap: TileMap = get_node("Buildings")
onready var tileMap2: TileMap = get_node("Buildings2")
onready var tileMap3: TileMap = get_node("Buildings3")
onready var mainNode = get_parent()

var placing

# Called when the node enters the scene tree for the first time.
func _ready():
	rng.randomize()

	# Create empty matrix
	for x in range(11):
		mapMatrix.append([])
		for y in range(11):
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
	'road': 8
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
	]
	return 0 < countAround(v, validConnections)

func _input(event):
	
	if !(event is InputEventMouseButton) && !(event is InputEventMouseMotion):
		return

	var mousePos = tileMap.world_to_map(tileMap.to_local(event.position))
	if mousePos.x < 0 || mousePos.x > 10 || mousePos.y < -10 || mousePos.y > 0 || (mousePos.x == 1 && mousePos.y == -1):
		return

	tileMap2.clear()
	tileMap3.clear()

	if event is InputEventMouseButton and event.button_index == BUTTON_LEFT and event.is_pressed():
		mouseClick(mousePos)
	elif event is InputEventMouseMotion:
		mouseMove(mousePos)

func mouseClick(mousePos: Vector2):
	
	if placing:
		if canBuild(mousePos):
			setMatrix(mousePos.x, mousePos.y, placing)
			placing = null
			mainNode.gameState = StateEnum.unblocked
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
	elif mapMatrix[mousePos.x][mousePos.y] == 'gather-wood':
		var mult = countAround(mousePos, ['wood'])
		mainNode.gatherHarvesterWood(mult)
	elif mapMatrix[mousePos.x][mousePos.y] == 'gather-stone':
		var mult = countAround(mousePos, ['stone'])
		mainNode.gatherHarvesterStone(mult)
	elif mapMatrix[mousePos.x][mousePos.y] == 'gather-gem':
		var mult = countAround(mousePos, ['gem'])
		mainNode.gatherHarvesterGem(mult)

func mouseMove(mousePos: Vector2):
	var cell
	if placing:
		tileMap3.set_cellv(mousePos, typeNumberDict[placing])
	else:
		cell = tileMap.get_cellv(mousePos)
		if cell != -1 && cell != 8 && cell != 18:
			tileMap2.set_cellv(mousePos, cell)

func placeBuilding(building):
	mainNode.AddAlert("Place Building")
	placing = building
	mainNode.gameState = StateEnum.unblocked
