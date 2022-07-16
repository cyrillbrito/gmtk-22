extends MarginContainer

var shopItems = [
	{
		building = 'workshop',
		name = "Workshop",
		description = "This building will allow you to upgrade your tools",
		price = [3,0,0,1],
		imgPath = "res://assets/Buildings/Workshop.png"
	},
	 {
		building = 'gather-wood',
		name = "Wood Harvester",
		description = "This building will allow you harvest all wood surrounding it",
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/WoodHarvester.png"
	},
	{
		building = 'gather-wood',
		name = "Stone Harvester",
		description = "This building will allow you harvest all stone surrounding it",
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/StoneHarvester.png"
	},
	{
		building = 'gather-gem',
		name = "Gem Harvester",
		description = "This building will allow you harvest all gem surrounding it",
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		building = null,
		name = "Upgrade tools",
		description = "Allows to break Stone",
		disabled = "true",
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		building = null,
		name = "2nd Upgrade tools",
		description = "Allows to break Gem",
		disabled = "true",
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
]

func _ready():
	var shopItemScene = preload("res://SideMenu/ShopItem.tscn")
	for key in shopItems:
		var scene = shopItemScene.instance()
		scene.Building = key.building;
		scene.ItemName = key.name;
		scene.WoodPrice = key.price[0]
		scene.StonePrice = key.price[1]
		scene.GemPrice = key.price[2]
		scene.ManaPrice = key.price[3]
		scene.imgPath = key.imgPath
		get_node("VBoxContainer/ScrollContainer/VBoxContainer/").add_child(scene)
