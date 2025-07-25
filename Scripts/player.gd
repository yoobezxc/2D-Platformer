extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY: float = 90.0
const SPEED: float = 40.0
const JUMP: float = -55.0
const JUMP_DELAY: float = 0.15

var is_jumping: bool
var time_elapsed: float

func respawn() -> void:
	self.position = Vector2(17.0, 150.0)

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	#print(velocity)
	#print(time_elapsed)             
	
	if not is_on_floor():
		self.velocity.y += GRAVITY * delta
		time_elapsed += delta
		
		if self.velocity.y > 0:
			sprite.play("fall_jump")
	
	if is_on_floor():
		is_jumping = false
		time_elapsed = 0.0
	
	if Input.is_action_pressed("RIGHT"):
		self.velocity.x = SPEED
		sprite.flip_h = false
		
		if is_on_floor():
			sprite.play("run")
	elif Input.is_action_pressed("LEFT"):
		self.velocity.x = -SPEED
		sprite.flip_h = true
		
		if is_on_floor():
			sprite.play("run")
	else:
		self.velocity.x = 0.0
		
		if is_on_floor():
			sprite.play("idle")
	
	if Input.is_action_just_pressed("SPACE") and not is_jumping and time_elapsed <= JUMP_DELAY:
		self.velocity.y = JUMP
		is_jumping = true
		
		if self.velocity.y < 0:
			sprite.play("start_jump")
	
	move_and_slide()
