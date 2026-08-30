extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var bar: ColorRect = $Bar
@onready var target_zone: ColorRect = $Bar/TargetZone
@onready var needle: ColorRect = $Bar/Needle
@onready var needle_sound: AudioStreamPlayer2D = $NeedleSound

var needle_speed := 400.0
var moving_right := true
var game_over := false
var original_y: float
var timer_end := false


func _ready() -> void:
	needle.position.x = 0.0
	original_y = needle.position.y

	await themed_timer.Timer(10.0)
	timer_end = true

	if not game_over:
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func _process(delta: float) -> void:
	if game_over:
		return

	if moving_right:
		needle.position.x += needle_speed * delta
	else:
		needle.position.x -= needle_speed * delta

	var bar_width := bar.size.x
	var needle_width := needle.size.x

	if needle.position.x + needle_width >= bar_width:
		needle.position.x = bar_width - needle_width
		moving_right = false

	elif needle.position.x <= 0:
		needle.position.x = 0
		moving_right = true


func _input(event: InputEvent) -> void:
	if game_over:
		return

	if event.is_action_pressed("ui_accept"):
		stop_needle()


func stop_needle() -> void:
	game_over = true

	needle_sound.play()

	var tween := create_tween()

	tween.set_trans(Tween.TRANS_QUAD)
	tween.set_ease(Tween.EASE_OUT)

	tween.tween_property(
		needle,
		"position:y",
		original_y - 80.0,
		0.7
	)

	tween.tween_callback(check_result)


func check_result() -> void:
	var needle_left := needle.position.x
	var needle_right := needle.position.x + needle.size.x

	var target_left := target_zone.position.x
	var target_right := target_zone.position.x + target_zone.size.x

	if needle_right >= target_left and needle_left <= target_right:
		Global.score += 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
	else:
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
