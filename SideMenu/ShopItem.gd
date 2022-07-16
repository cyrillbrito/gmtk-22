extends Control

enum ItemType {Wood, Stone, Gem, Mana}
#enum BuildingType {WoodHouse, StoneHouse, GemHouse, Workshop}

export var ItemName = 'Upgrade tools'
export var WoodPrice = 4
export var StonePrice = 3
export var GemPrice = 2
export var ManaPrice = 1
export var imgPath = "res://assets/Buildings/castle.png"

func _ready():
	get_node("HBoxContainer2/VBoxContainer/HBoxContainer/Name").text = ItemName
	get_node("HBoxContainer2/Sprite").texture = load(imgPath)
	setPrice()

func _on_BuyButton_pressed():
	pass # Replace with function body.

func setPrice():
	var ItemScene = preload("res://SideMenu/ResourceIcon&Quantity.tscn")
	if WoodPrice > 0:
		var woodIconScene = ItemScene.instance()
		woodIconScene.quantity = WoodPrice;
		woodIconScene.type = ItemType.Wood		
		get_node("HBoxContainer2/VBoxContainer/Price").add_child(woodIconScene)
	if StonePrice > 0:
		var stoneIconScene = ItemScene.instance()
		stoneIconScene.quantity = StonePrice;
		stoneIconScene.type = ItemType.Stone		
		get_node("HBoxContainer2/VBoxContainer/Price").add_child(stoneIconScene)
	if GemPrice > 0:
		var gemIconScene = ItemScene.instance()
		gemIconScene.quantity = GemPrice;
		gemIconScene.type = ItemType.Stone		
		get_node("HBoxContainer2/VBoxContainer/Price").add_child(gemIconScene)
	if ManaPrice > 0:
		var manaIconScene = ItemScene.instance()
		manaIconScene.quantity = ManaPrice;
		manaIconScene.type = ItemType.Mana		
		get_node("HBoxContainer2/VBoxContainer/Price").add_child(manaIconScene)
