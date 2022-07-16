extends MarginContainer

var shopItems = [
	{
		name = "Workshop",
		price = [3,0,0,1],
		imgPath = "res://assets/Buildings/Workshop.png"
	},
	 {
		name = "Wood Harvester",
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/WoodHarvester.png"
	},
	{
		name = "Stone Harvester",
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/StoneHarvester.png"
	},
	{
		name = "Gem Harvester",
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	 {
		name = "Upgrade tools",
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		name = "2nd Upgrade tools",
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
]

func _ready():
	var shopItemScene = preload("res://SideMenu/ShopItem.tscn")
	for key in shopItems:
		var scene = shopItemScene.instance()
		scene.name = key.name;
		scene.WoodPrice = key.price[0]
		scene.StonePrice = key.price[1]
		scene.GemPrice = key.price[2]
		scene.ManaPrice = key.price[3]
		scene.imgPath = key.imgPath
		get_node("VBoxContainer/ScrollContainer/VBoxContainer/").add_child(scene)
