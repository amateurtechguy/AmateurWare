extends Area2D

@export var fall_speed := 150.0

func _process(delta):
	position.y += fall_speed * delta

func _on_body_entered(body) -> void:
	if body.name == "Player":
		get_parent().stardust_collect()
		$AudioStreamPlayer2D.play()
		queue_free()
