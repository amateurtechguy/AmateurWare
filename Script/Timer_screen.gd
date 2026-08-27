extends Node2D

@onready var garlic_container: HBoxContainer = $GarlicContainer
@onready var garlic: TextureRect = $GarlicContainer/garlic
@onready var garlic_2: TextureRect = $GarlicContainer/garlic_2
@onready var garlic_3: TextureRect = $GarlicContainer/garlic_3
@onready var garlic_4: TextureRect = $GarlicContainer/garlic_4
@onready var garlic_5: TextureRect = $GarlicContainer/garlic_5
@onready var level: RichTextLabel = $Level
@onready var timer: RichTextLabel = $Timer

var time

var available_minigames := [
	"res://Scenes/minigame_1.tscn",
	"res://Scenes/minigame_2.tscn",
	"res://Scenes/minigame_3.tscn",
	"res://Scenes/minigame_4.tscn",
	"res://Scenes/minigame_5.tscn",
	"res://Scenes/minigame_6.tscn"
]


func _ready() -> void:
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/lose_screen.tscn")
		return

	await Timer(3.0)

	if Global.minigames_done < 6:
		Global.minigames_done += 1

		var possible_minigames = available_minigames.duplicate()

		if Global.last_minigame == "res://Scenes/minigame_1.tscn":
			possible_minigames.erase("res://Scenes/minigame_1.tscn")
		elif Global.last_minigame == "res://Scenes/minigame_2.tscn":
			possible_minigames.erase("res://Scenes/minigame_2.tscn")
		elif Global.last_minigame == "res://Scenes/minigame_3.tscn":
			possible_minigames.erase("res://Scenes/minigame_3.tscn")
		elif Global.last_minigame == "res://Scenes/minigame_4.tscn":
			possible_minigames.erase("res://Scenes/minigame_4.tscn")
		elif Global.last_minigame == "res://Scenes/minigame_5.tscn":
			possible_minigames.erase("res://Scenes/minigame_5.tscn")
		elif Global.last_minigame == "res://Scenes/minigame_6.tscn":
			possible_minigames.erase("res://Scenes/minigame_6.tscn")

		var random_minigame = possible_minigames.pick_random()

		Global.last_minigame = random_minigame

		get_tree().change_scene_to_file(random_minigame)

	else:
		get_tree().change_scene_to_file("res://Scenes/node_2d.tscn")


func _process(_delta: float) -> void:
	if Global.lives <= 0:
		get_tree().change_scene_to_file("res://Scenes/lose_screen.tscn")
		return

	match Global.lives:
		5:
			pass

		4:
			garlic.hide()

		3:
			garlic.hide()
			garlic_2.hide()

		2:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()

		1:
			garlic.hide()
			garlic_2.hide()
			garlic_3.hide()
			garlic_4.hide()

		0:
			garlic_container.hide()

	timer.text = str(time)
	level.text = "Level " + str(Global.minigames_done)


func Timer(start_time: float) -> void:
	time = start_time

	while time > 0.0:
		await wait(0.1)
		time = max(time - 0.1, 0.0)


func wait(seconds: float) -> void:
	await get_tree().create_timer(seconds).timeout
