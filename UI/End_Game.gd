extends Control


func _ready():
	$Label.text = "Thanks for Playing!\n Your Final Score was " + str(Global.score) + "."

func _on_play_button_pressed():
	Global.reset()
	get_tree().change_scene_to_file("res://game.tscn")


func _on_quit_button_pressed():
	get_tree().quit()
