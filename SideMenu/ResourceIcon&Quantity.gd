extends HBoxContainer

enum ItemType {Wood, Stone, Gem, Mana}
export(ItemType) var type = ItemType.Wood
export var quantity = 10
export var textSize = 22


func _ready():
	get_node("Quantity").text = str(quantity)
	if type == ItemType.Wood:
		$Img.texture = load('res://assets/ResourcesIcons/Wood.png')
	if type == ItemType.Stone:
		$Img.texture = load('res://assets/ResourcesIcons/Stone.png')
	if type ==ItemType.Gem:
		$Img.texture = load('res://assets/ResourcesIcons/Gem.png')
	if type ==ItemType.Mana:
		$Img.texture = load('res://assets/ResourcesIcons/Mana.png')
