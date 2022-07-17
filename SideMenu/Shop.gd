extends TextureRect

export var shopItems = [
	{
		building = 'road',
		name = "Road",
		description = "Expand our kindom using roads, all buildings need to be connected",
		disabled = false,
		price = [5,3,0,1],
		imgPath = "res://assets/Buildings/Road.png"
	},
	{
		building = 'workshop',
		name = "Workshop",
		description = "Allows you to upgrade your tools",
		disabled = false,
		price = [10,0,0,2],
		imgPath = "res://assets/Buildings/Workshop.png"
	},
	{
		building = "",
		name = "Upgrade tools",
		description = "Allows you to break Stone and increases the wood harvest",
		disabled = true,
		price = [5,0,0,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		building = "",
		name = "2nd Upgrade tools",
		description = "Allows to break Gems and increases the harvest of other resources",
		disabled = true,
		price = [20,10,0,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	 {
		building = 'gather-wood',
		name = "Wood Harvester",
		description = "Receive wood each day depending on # blocks with wood around it",
		disabled = false,
		price = [10,0,0,2],
		imgPath = "res://assets/Buildings/WoodHarvester.png"
	},
	{
		building = 'gather-stone',
		name = "Stone Harvester",
		description = "Receive stone each day depending on # blocks with stone around it",
		disabled = false,
		price = [20,15,0,2],
		imgPath = "res://assets/Buildings/StoneHarvester.png"
	},
	{
		building = 'gather-gem',
		name = "Gem Harvester",
		description = "Receive gems each day depending on # blocks with gems around it",
		disabled = false,
		price = [30,20,10,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		building = 'castle',
		name = "Castle",
		description = "...",
		disabled = false,
		price = [100,50,30,4],
		# price = [100,50,20,4],
		imgPath = "res://assets/Buildings/castle.png"
	},
]

onready var mainNode = get_node("/root/Main")

func _ready():
	var shopItemScene = preload("res://SideMenu/ShopItem.tscn")
	for key in shopItems:
			var scene = shopItemScene.instance()
			scene.Building = key.building
			scene.ItemName = key.name
			scene.ItemDescription = key.description
			scene.WoodPrice = key.price[0]
			scene.StonePrice = key.price[1]
			scene.GemPrice = key.price[2]
			scene.ManaPrice = key.price[3]
			scene.imgPath = key.imgPath
			scene.disabled = key.disabled
			get_node("VBoxContainer/TextureRect/ScrollContainer/VBoxContainer").add_child(scene)
	
func UpdateShop(name):
	var shopItems = get_node("VBoxContainer/TextureRect/ScrollContainer/VBoxContainer").get_children()
	if(name == "Workshop"):
		shopItems[1].disabled = true
		shopItems[2].disabled = false
	if(name == "Upgrade tools"):
		shopItems[2].disabled = true
		shopItems[3].disabled = false	
		mainNode.toolsLevel= 2
	if(name == "2nd Upgrade tools"):
		shopItems[3].disabled = true
		mainNode.toolsLevel= 3
	if(name == "Castle"):
		shopItems[7].disabled = true
		mainNode.toolsLevel= 3
