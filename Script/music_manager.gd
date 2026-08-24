extends Node

@onready var music: AudioStreamPlayer2D = $Music


func play_music() -> void:
	if not music.playing:
		music.play()


func stop_music() -> void:
	music.stop()
