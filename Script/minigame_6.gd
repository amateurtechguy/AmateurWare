extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var target: TextureButton = $Target
@onready var target_timer: Timer = $TargetTimer

var target_clicked = false
var timer_end = false
var completed = false


func _ready() -> void:
	randomize_target()
	target_timer.start()

	await themed_timer.Timer(15.0)
	timer_end = true


func _process(_delta: float) -> void:
	if timer_end and not completed:
		completed = true
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func _on_target_pressed() -> void:
	if completed:
		return

	print("TARGET CLICKED!")

	target_clicked = true
	completed = true
	Global.score += 1
	get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func _on_target_timer_timeout() -> void:
	target.hide()
	await get_tree().create_timer(0.15).timeout

	if not target_clicked and not timer_end:
		randomize_target()
		target.show()


func randomize_target() -> void:
	var viewport_size = get_viewport_rect().size

	var x = randf_range(50, viewport_size.x - 50)
	var y = randf_range(100, viewport_size.y - 50)

	target.position = Vector2(x, y)
