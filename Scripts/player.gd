extends CharacterBody2D
const SPEED = 150.0
var direction
@export var scene_to_load : PackedScene
@onready var animated_sprite : AnimatedSprite2D = $AnimatedSprite2D
func _physics_process(_delta):
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	if direction:
		velocity.x = direction.x * SPEED
		velocity.y = direction.y * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.y = move_toward(velocity.y, 0, SPEED)
	
	update_anim()
	move_and_slide()
func update_anim():
	if direction.x != 0:
		animated_sprite.play("walk-side")
		animated_sprite.flip_h = direction.x < 0
	else:
		if direction.y < 0:
			animated_sprite.play("walk-back")
		elif direction.y > 0:
			animated_sprite.play("walk-front")
		else:
			animated_sprite.play("idle")


func _on_transition_char_move(tp_x, tp_y):
	position.x = tp_x
	position.y = tp_y
