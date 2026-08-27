extends Node2D

@onready var themed_timer: Node2D = $ThemedTimer
@onready var hatched_egg: TextureRect = $HatchedEgg
@onready var egg: TextureButton = $Egg
@onready var mash_label: Label = $MashLabel
@onready var mash_sound: AudioStreamPlayer2D = $MashSound
@onready var hash_sound: AudioStreamPlayer2D = $HashSound

var mashes = 0
var mash_goal = 30
var timer_end = false
var egg_hatched = false
var shaking = false

func _ready() -> void:
	hatched_egg.hide()
	mash_label.text = "0 / 30"
	await themed_timer.Timer(15.0)

	if not egg_hatched:
		timer_end = true

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_SPACE) and not egg_hatched and not shaking:
		mash_egg()

	if mashes >= mash_goal and not egg_hatched:
		egg_hatched = true
		timer_end = false
		await hatch_egg()

	if timer_end and not egg_hatched:
		Global.minigames_done -= 1
		Global.lives -= 1
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")

func mash_egg() -> void:
	if egg_hatched:
		return

	mashes += 1
	mash_label.text = str(mashes) + " / " + str(mash_goal)
	mash_sound.play()
	shake_egg()

func shake_egg() -> void:
	shaking = true
	var original_position = egg.position

	var tween = create_tween()
	tween.tween_property(egg, "position", original_position + Vector2(-8, 0), 0.04)
	tween.tween_property(egg, "position", original_position + Vector2(8, 0), 0.04)
	tween.tween_property(egg, "position", original_position + Vector2(-6, 0), 0.04)
	tween.tween_property(egg, "position", original_position + Vector2(6, 0), 0.04)
	tween.tween_property(egg, "position", original_position, 0.04)
	await tween.finished

	shaking = false

func hatch_egg() -> void:
	egg.hide()
	hatched_egg.show()
	hash_sound.play()

	await get_tree().create_timer(1.5).timeout

	if Global.minigames_done >= 6:
		get_tree().change_scene_to_file("res://Scenes/done_screen.tscn")
	else:
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn")
