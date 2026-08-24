extends Node2D


func _ready() -> void:
	MusicManager.play_music()


func _process(_delta: float) -> void:
	pass


func _on_start_pressed() -> void:
	Global.lives = 5
	Global.minigames_done = 0

	MusicManager.stop_music()

	get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")


func _on_settings_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/settings.tscn")


func _on_quit_pressed() -> void:
	get_tree().quit()
