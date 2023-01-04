extends KinematicBody2D

var speed = 250
var velocity = Vector2()

var walking = false
var attacking = false

var direction = "right"

func _physics_process(_delta):
	velocity = Vector2()
	
	if Input.is_action_just_pressed("ui_drop"):
		Inventory.remove_first()

	if Input.is_action_pressed("ui_attack"):
		attacking=true
		walking=false
	else:
		if Input.is_action_pressed("ui_right"):
			direction = "side"
			velocity.x += 1			
			$Sprite.flip_h=false
			attacking=false
			walking=true
		elif Input.is_action_pressed("ui_left"):
			direction = "side"
			velocity.x -= 1			
			$Sprite.flip_h=true
			attacking=false
			walking=true
			
		elif Input.is_action_pressed("ui_down"):
			direction = "down"
			velocity.y += 1
			attacking=false
			walking=true
			
		elif Input.is_action_pressed("ui_up"):
			direction = "up"
			velocity.y -= 1
			attacking=false
			walking=true

	# Normalizando a velocidade 
	if velocity.length() > 0:
		velocity = velocity.normalized()

	if attacking and Inventory.has_item("sword"):
			$Sprite.play("attack-" + direction)
	elif walking:
		$Sprite.play("walk-" + direction)

	if velocity.x == 0 and velocity.y == 0 and not attacking:
		$Sprite.stop()

	velocity = move_and_slide(velocity * speed)

func _on_Sprite_animation_finished():
	if $Sprite.animation.substr(0, 6) == "attack":
		attacking=false
		
	if $Sprite.animation.substr(0, 4) == "walk":
		walking=false
