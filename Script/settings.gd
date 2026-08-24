extends Node2D

@onready var volume_button: TextureButton = $VolumeButton

var muted := false

var volume_on_texture = preload("res://Assets/volume_on-removebg-preview.png")
var volume_off_texture = preload("res://Assets/volume_off-removebg-preview.png")


func _ready() -> void:
	volume_button.texture_normal = volume_on_texture

func _process(_delta: float) -> void:
	pass


func _on_volume_button_pressed() -> void:
	muted = !muted

	var master_bus := AudioServer.get_bus_index("Master")

	AudioServer.set_bus_mute(master_bus, muted)

	if muted:
		volume_button.texture_normal = volume_off_texture
	else:
		volume_button.texture_normal = volume_on_texture

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn") # Replace with function body.


func _on_full_screen_pressed() -> void:
	if DisplayServer.window_get_mode() == DisplayServer.WINDOW_MODE_FULLSCREEN:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_WINDOWED)
	else:
		DisplayServer.window_set_mode(DisplayServer.WINDOW_MODE_FULLSCREEN)
