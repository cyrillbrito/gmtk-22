extends Node2D


var mapMatrix = []
#var OurRandom = preload("OurRandom.gd")

onready var rng = RandomNumberGenerator.new()
onready var tileMap = get_node("Buildings")


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
			generate1(x, y)
	
	# Stage 2
	for x in range(4, 8):
		for y in range(0, 4):
			generate2(x, y)
	for x in range(4, 8):
		for y in range(4, 8):
			generate2(x, y)
	for x in range(0, 4):
		for y in range(4, 8):
			generate2(x, y)

	for x in range(8, 11):
		for y in range(0, 8):
			generate3(x, y)
	for x in range(8, 11):
		for y in range(8, 11):
			generate3(x, y)
	for x in range(0, 8):
		for y in range(8, 11):
			generate3(x, y)
	

	
	print(mapMatrix)



func generate1(x, y):

	if x == 1 && y == 1:
		setMatrix(x, y, 'main')
		return
	
	var rand = rng.randf()
	
	if rand < .3:
		setMatrix(x, y, 'tree')
		return


func generate2(x, y):

	var rand = rng.randf()
	
	if rand < .15:
		setMatrix(x, y, 'stone')
		return

	if rand < .25:
		setMatrix(x, y, 'tree')
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
	'main': 19,
	'tree': 12,
	'stone': 13,
	'gem': 14,
	'gather-gem': 15,
	'gather-stone': 16,
	'gather-wood': 17,
	'workshop': 18
}

func setMatrix(x, y, type):
	var number = typeNumberDict[type]
	tileMap.set_cell(x, -y, number)
	mapMatrix[x][y] = type
