extends CharacterBody2D


var speed = 5
var max_speed = 400
var rotate_speed = 0.08
var nose = Vector2(0, -80)
var health = 10
var bullet = load("res://Player/bullet.tscn")
var Effects = null 
var Explosion = load("res://Effects/explosion.tscn")

func get_input():
	var to_return = Vector2.ZERO
	$Exhaust.hide()
	if Input.is_action_pressed("Forward"):
		to_return += Vector2(0,-1)
		$Exhaust.show()
	if Input.is_action_pressed("Left"):
			rotation -= rotate_speed
	if Input.is_action_pressed("Right"):
			rotation += rotate_speed
	return to_return.rotated(rotation)

func _physics_process(_delta):
	velocity += get_input()*speed
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
		
	
	position.x = wrapf(position.x, 0, Global.VP.x)
	position.y = wrapf(position.y, 0, Global.VP.y)
	velocity = velocity.normalized() * clamp(velocity.length(), 0, max_speed)
	
	
	move_and_slide()
	
	if Input.is_action_just_pressed("Shoot"):
		var Bullet = bullet.instantiate()
		Bullet.position = position + nose.rotated(rotation)
		Bullet.rotation = rotation
		var Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			Effects.add_child(Bullet)
			
		
func damage(d):
	health -= d
	if health <= 0:
		Effects = get_node_or_null("/root/Game/Effects")
		if Effects != null:
			var the_Explosion = Explosion.instantiate()
			Effects.add_child(the_Explosion)
			the_Explosion.global_position = global_position
			hide()
			await the_Explosion.animation_finished
		Global.update_Lives(-1)
		queue_free() 


func _on_area_2d_body_entered(body):
	if body.name != "Player": 
		damage(100)
