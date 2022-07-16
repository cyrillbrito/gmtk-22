extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var w = 11
var h = 11

var mapMatrix=[]

var OurRandom = preload("OurRandom.gd")
var random

var tileMap


# Called when the node enters the scene tree for the first time.
func _ready():

	random = OurRandom.new()
	tileMap = get_node("Buildings")

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
	
	var rand = random.goFloat()
	
	if rand < .35:
		setMatrix(x, y, 'tree')
		return


func generate2(x, y):

	var rand = random.goFloat()
	
	if rand < .2:
		setMatrix(x, y, 'stone')
		return

	if rand < .4:
		setMatrix(x, y, 'tree')
		return


func generate3(x, y):

	var rand = random.goFloat()
	
	if rand < .2:
		setMatrix(x, y, 'gem')
		return

	if rand < .4:
		setMatrix(x, y, 'stone')
		return



var typeNumberDict = {
	'main': 8,
	'tree': 11,
	'stone': 10,
	'gem': 9,
}

func setMatrix(x, y, type):
	var number = typeNumberDict[type]
	tileMap.set_cell(x, -y, number)
	mapMatrix[x][y] = type
