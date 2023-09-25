extends AnimatedSprite2D

func _ready():
	play("new_animation")


func _on_animation_finished():
	queue_free()
