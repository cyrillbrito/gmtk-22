extends HBoxContainer

signal result

var random = RandomNumberGenerator.new()

func _ready():
	random.randomize()

func roll():
	var diceValue = random.randi_range(1, 6)
	print('Rolling Dice...')
	yield(get_tree().create_timer(2), "timeout")
	print('Rolled a ', diceValue)
	return diceValue
