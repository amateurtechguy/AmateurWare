extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer

var garlic_collected = 0
var timer_end = false
var completed = false


func _ready() -> void:
	await themed_timer.Timer(10.0)
	timer_end = true


func _process(_delta: float) -> void:
	if garlic_collected == 3 and not completed:
		completed = true
		Global.score += 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")

	if timer_end and not completed:
		completed = true
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func garlic_collect() -> void:
	garlic_collected += 1


func _on_stardust_garlic_collected() -> void:
	garlic_collect()


func _on_stardust_2_garlic_collected() -> void:
	garlic_collect()


func _on_stardust_3_garlic_collected() -> void:
	garlic_collect()
