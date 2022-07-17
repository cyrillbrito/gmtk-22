extends MarginContainer

export var wonInTurns = 0;

func _ready():
	var label: Label = get_node("MarginContainer/Label")
	if wonInTurns > 0:
		$WinAudio.play()
		label.text = 'Great game!\nYou won in ' + str(wonInTurns) + ' turns.'
	else:
		$GameOverAudio.play()
		print("pong")
		label.text = 'You ran out of time...'
		var continueBtn = get_node("MarginContainer/Container2")
		continueBtn.queue_free()


func _on_PlayAgain_pressed():
	get_tree().reload_current_scene()


func _on_Continue_pressed():
	queue_free()
