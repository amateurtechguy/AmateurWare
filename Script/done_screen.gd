extends Node2D


@onready var score_label: RichTextLabel = $RichTextLabel3


func _ready() -> void:
	score_label.text = "YOU GOT " + str(Global.score) + " GAMES DONE!!"


func _on_button_pressed() -> void:
	Global.lives = 5
	Global.score = 0
	Global.last_minigame = ""
	get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")
