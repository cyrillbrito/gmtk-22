extends Control

enum ItemType {Wood, Stone, Gem, Mana}

export var WoodPrice = 4;
export var StonePrice = 3;
export var GemPrice = 2;
export var ManaPrice = 1;

func _ready():
	var ItemScene = preload("res://SideMenu/ResourceIcon&Quantity.tscn")
	if WoodPrice > 0:
		var woodIconScene = ItemScene.instance()
		woodIconScene.quantity = WoodPrice;
		woodIconScene.type = ItemType.Wood		
		get_node("Price").add_child(woodIconScene)
	if StonePrice > 0:
		var stoneIconScene = ItemScene.instance()
		stoneIconScene.quantity = StonePrice;
		stoneIconScene.type = ItemType.Stone		
		get_node("Price").add_child(stoneIconScene)
	if GemPrice > 0:
		var gemIconScene = ItemScene.instance()
		gemIconScene.quantity = GemPrice;
		gemIconScene.type = ItemType.Stone		
		get_node("Price").add_child(gemIconScene)
	if ManaPrice > 0:
		var manaIconScene = ItemScene.instance()
		manaIconScene.quantity = ManaPrice;
		manaIconScene.type = ItemType.Mana		
		get_node("Price").add_child(manaIconScene)
		

