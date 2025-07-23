extends AnimatedSprite2D

var init_pos: Vector2

func _ready() -> void:
	self.play("idle")
	init_pos = self.global_position

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		init_pos.y -= 10.0
		var tween = get_tree().create_tween()
		tween.tween_property(self, "position", init_pos, 0.6).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_callback(self.queue_free)
