extends Node2D


var Player = load("res://Player/player.tscn")

func _physics_process(delta):
	if get_child_count() == 0:
		var the_player = Player.instantiate()
		the_player.position = Vector2(576,324)
		add_child(the_player)
