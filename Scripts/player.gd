extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY: float = 90.0
const SPEED: float = 20.0
const JUMP: float = -50.0

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		self.velocity.y += GRAVITY * delta
		
		if self.velocity.y > 0:
			sprite.play("fall_jump")
	
	if Input.is_action_pressed("RIGHT"):
		self.velocity.x += SPEED * delta
		sprite.flip_h = false
		
		if is_on_floor():
			sprite.play("run")
	elif Input.is_action_pressed("LEFT"):
		self.velocity.x -= SPEED * delta
		sprite.flip_h = true
		
		if is_on_floor():
			sprite.play("run")
	else:
		self.velocity.x = lerp(self.velocity.x, 0.0, 0.2)
		
		if is_on_floor():
			sprite.play("idle")
	
	if Input.is_action_pressed("SPACE") and is_on_floor():
		self.velocity.y = JUMP
		
		if self.velocity.y < 0:
			sprite.play("start_jump")
	
	move_and_slide()

func easeOutSine(x: float) -> float:
	return sin((x * PI) / 2)
