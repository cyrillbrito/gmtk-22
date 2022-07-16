extends MarginContainer

var shopItems = [
	{
		name = "Road",
		description = "This will allow to build other buildings",
		disabled = false,
		price = [2,1,0,1],
		imgPath = "res://assets/Buildings/Road.png"
	},
	{
		name = "Workshop",
		description = "This building will allow you to upgrade your tools",
		disabled = false,
		price = [3,0,0,1],
		imgPath = "res://assets/Buildings/Workshop.png"
	},
	 {
		name = "Wood Harvester",
		description = "This building will allow you harvest all wood surrounding it",
		disabled = false,
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/WoodHarvester.png"
	},
	{
		name = "Stone Harvester",
		description = "This building will allow you harvest all stone surrounding it",
		disabled = false,
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/StoneHarvester.png"
	},
	{
		name = "Gem Harvester",
		description = "This building will allow you harvest all gem surrounding it",
		disabled = false,
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	 {
		name = "Upgrade tools",
		description = "Allows to break Stone",
		disabled = true,
		price = [3,1,0,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
	{
		name = "2nd Upgrade tools",
		description = "Allows to break Gem",
		disabled = true,
		price = [3,1,2,2],
		imgPath = "res://assets/Buildings/GemHarvester.png"
	},
]

func _ready():
	var shopItemScene = preload("res://SideMenu/ShopItem.tscn")
	for key in shopItems:
		if !key.disabled:
			var scene = shopItemScene.instance()
			scene.ItemName = key.name;
			scene.WoodPrice = key.price[0]
			scene.StonePrice = key.price[1]
			scene.GemPrice = key.price[2]
			scene.ManaPrice = key.price[3]
			scene.imgPath = key.imgPath
			get_node("VBoxContainer/ScrollContainer/VBoxContainer/").add_child(scene)
