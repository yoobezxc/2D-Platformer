extends CharacterBody2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

const GRAVITY: float = 90.0

func _ready() -> void:
	sprite.play("idle")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("RIGHT"):
		self.velocity.x += 50.0 * delta
		sprite.flip_h = false
		
		if is_on_floor():
			sprite.play("run")
	elif Input.is_action_pressed("LEFT"):
		self.velocity.x -= 50.0 * delta
		sprite.flip_h = true
		
		if is_on_floor():
			sprite.play("run")
	else:
		self.velocity.x = 0.0
		
		if is_on_floor():
			sprite.play("idle")
	
	if Input.is_action_pressed("SPACE") and is_on_floor():
		self.velocity.y = -60.0
		
		if self.velocity.y < 0:
			sprite.play("start_jump")
	
	if not is_on_floor():
		self.velocity.y += GRAVITY * delta
		
		if self.velocity.y > 0:
			sprite.play("fall_jump")
	
	move_and_slide()
