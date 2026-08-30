extends Node2D

var stardust_scene = preload("res://Scenes/stardust_fall.tscn")
@onready var themed_timer: Node2D = $ThemedTimer
@onready var collect_sound: AudioStreamPlayer2D = $CollectSound

var stardust_collected = 0
var timer_end = false
var completed = false


func spawn_stardust() -> void:
	var stardust = stardust_scene.instantiate()
	add_child(stardust)

	stardust.position = Vector2(
		randf_range(-1000, -300),
		-188
	)


func stardust_spawner() -> void:
	while not timer_end:
		spawn_stardust()
		await get_tree().create_timer(1.0).timeout


func _ready() -> void:
	stardust_spawner()

	await themed_timer.Timer(10.0)
	timer_end = true


func _process(_delta: float) -> void:
	if stardust_collected == 8 and not completed:
		completed = true
		Global.score += 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
		return

	if timer_end and not completed:
		completed = true
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func stardust_collect() -> void:
	stardust_collected += 1
	collect_sound.play()
