extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var rnd

func _ready():
	var unix_time = OS.get_unix_time()

	rnd = RandomNumberGenerator.new()
	rnd.set_seed(unix_time)


func goFloat():
	return rnd.randf()

func goDice():
	return rnd.randi_range(1,6)

