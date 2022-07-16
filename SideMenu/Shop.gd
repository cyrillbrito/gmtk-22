extends MarginContainer

export var shopItems = [
	{
		building = 'road',
		name = "Road",
		description = "This will allow to build other buildings",
		disabled = false,
		price = [2,1,0,1],
		imgPath = "res://assets/Buildings/Road.png"
	},
	{
		building = 'workshop',
		name = "Workshop",
		description = "This building will allow you to upgrade your tools",
		disabled = false,
		price = [3,0,0,1],
		imgPath = "res://assets/Buildings/Workshop.png"
	},
	 {
		building = 'gather-wood',
		name = "Wood Harvester",
		description = "This building will allow you harvest all wood surrounding it",
		disabled = false,
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/WoodHarvester.png"
	},
	{
		building = 'gather-wood',
		name = "Stone Harvester",
		description = "This building will allow you harvest all stone surrounding it",
		disabled = false,
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/StoneHarvester.png"
	},
	{
		building = 'gather-gem',
		name = "Gem Harvester",
		description = "This building will allow you harvest all gem surrounding it",
		disabled = false,
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		building = "",
		name = "Upgrade tools",
		description = "Allows to break Stone",
		disabled = true,
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		building = "",
		name = "2nd Upgrade tools",
		description = "Allows to break Gem",
		disabled = true,
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
]

onready var mainNode = get_node("/root/Main")

func _ready():
	var shopItemScene = preload("res://SideMenu/ShopItem.tscn")
	for key in shopItems:
			var scene = shopItemScene.instance()
			scene.Building = key.building
			scene.ItemName = key.name
			scene.WoodPrice = key.price[0]
			scene.StonePrice = key.price[1]
			scene.GemPrice = key.price[2]
			scene.ManaPrice = key.price[3]
			scene.imgPath = key.imgPath
			scene.disabled = key.disabled
			get_node("VBoxContainer/ScrollContainer/VBoxContainer/").add_child(scene)
	
func UpdateShop(name):
	var shopItems = get_node("VBoxContainer/ScrollContainer/VBoxContainer/").get_children()
	if(name == "Workshop"):
		shopItems[1].disabled = true
		shopItems[5].disabled = false
	if(name == "Upgrade tools"):
		shopItems[5].disabled = true
		shopItems[6].disabled = false	
		mainNode.toolsLevel= 2
	if(name == "2nd Upgrade tools"):
		shopItems[6].disabled = true
		mainNode.toolsLevel= 3
