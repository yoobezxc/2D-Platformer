extends Node2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	sprite.play("idle")

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		body.respawn()
