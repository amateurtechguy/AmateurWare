extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer

var buttons_pressed := 0
var timer_end := false

@onready var buttons = [
	$Button_1,
	$Button_2,
	$Button_3,
	$Button_4,
	$Button_5,
	$Button_6,
	$Button_7,
	$Button_8
]


func _ready() -> void:
	randomize()

	# Hide all buttons
	for button in buttons:
		button.hide()

	# Show the first random button
	show_random_button()

	# Start the timer
	await themed_timer.Timer(7.0)

	# If the player hasn't collected 4 potions, they lose
	if buttons_pressed < 4:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func show_random_button() -> void:
	if buttons_pressed >= 4:
		return

	var button = buttons.pick_random()

	# Pick another button if this one is already visible
	while button.visible:
		button = buttons.pick_random()

	button.position = Vector2(
		randf_range(100, 1000),
		randf_range(100, 500)
	)

	button.show()


func _process(_delta: float) -> void:
	print("Potions collected: ", buttons_pressed)

	# WIN
	if buttons_pressed >= 4:
		if Global.minigames_done >= 3:
			get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
		else:
			get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")

		return

	# LOSE
	if timer_end:
		Global.lives -= 1
		Global.minigames_done -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func _on_button_1_pressed() -> void:
	$Button_1.hide()
	$Button_1/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_2_pressed() -> void:
	$Button_2.hide()
	$Button_2/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_3_pressed() -> void:
	$Button_3.hide()
	$Button_3/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_4_pressed() -> void:
	$Button_4.hide()
	$Button_4/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_5_pressed() -> void:
	$Button_5.hide()
	$Button_5/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_6_pressed() -> void:
	$Button_6.hide()
	$Button_6/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_7_pressed() -> void:
	$Button_7.hide()
	$Button_7/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()


func _on_button_8_pressed() -> void:
	$Button_8.hide()
	$Button_8/AudioStreamPlayer2D.play()
	buttons_pressed += 1
	show_random_button()
