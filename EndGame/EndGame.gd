extends Container

export var wonInTurns = 0;

func _ready():
	var label: Label = get_node("TextureRect/MarginContainer/Label")
	if wonInTurns > 0:
		$WinAudio.play()
		label.text = 'Great game!\nYou won in ' + str(wonInTurns) + ' turns.\n'
	else:
		$GameOverAudio.play()
		print("pong")
		label.text = 'You ran out of time...\n'
		var continueBtn = get_node("TextureRect/MarginContainer/Container2")
		continueBtn.queue_free()

func _on_PlayAgain_pressed():
	get_tree().reload_current_scene()

func _on_Continue_pressed():
	queue_free()
