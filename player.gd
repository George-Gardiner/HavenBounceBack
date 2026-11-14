extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var energy: float = 100.0;

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor() and energy > 0:
		velocity.y = JUMP_VELOCITY
		energy -= 10

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("Left", "Right")
	if direction and energy > 0:
		velocity.x = direction * SPEED
		energy -= 10.0*delta
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	var collision = move_and_collide(velocity*delta, true)
	if collision:
		var collider = collision.get_collider()
		if (collider.has_meta("Bouncy") and collider.get_meta("Bouncy")):
			velocity.y *= -1
	
	
	move_and_slide()
