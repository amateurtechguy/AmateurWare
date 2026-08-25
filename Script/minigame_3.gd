extends Node2D

var stardust_scene = preload("res://Scenes/stardust_fall.tscn")
@onready var themed_timer: Node2D = $ThemedTimer 
# ^^^ You dragged this in the scene by the way 


var stardust_collected = 0 # just keeping track of stardust collected
var timer_end = false # boolean (true or false) stating whether the timer ended


func spawn_stardust() -> void:
	var stardust = stardust_scene.instantiate()
	add_child(stardust)
	stardust.position = Vector2(randf_range(-780, -570), -188)






func stardust_spawner() -> void:
	while not timer_end:
		print("SPAWNING STARDUST")
		spawn_stardust()
		await get_tree().create_timer(1.0).timeout



func _ready() -> void:

		#Below you can see that I have a function that I named. I grab a 
		#function from it that was created in it's script and use `await` to 
		# tell the script to wait for a signal, or for when a function finishes

	stardust_spawner()

	await themed_timer.Timer(10.0) #accessing a function from this node
	#after this is completed...
	timer_end = true # now we're saying "oh ye you ran out of time"


func _process(_delta: float) -> void: # running every frame brochacho
	if stardust_collected == 8: # the double equals is just an argument asking if it's the same, with "=" it'll give an error
		if Global.minigames_done >= 6: # we access a global script and see how many minigames have been completed
			get_tree().change_scene_to_file("res://Scenes/done_screen.tscn") # change current play scene into another, but you make your own finish screen in a later challenge, dont worry abt this rn
		else:
			get_tree().change_scene_to_file("res://Scenes/level_scene.tscn") # go back to the intermission scene
	
	if timer_end: # if the timer does end...
		Global.minigames_done -= 1 # go back a minigame
		Global.lives -= 1 # lose ur lives
		get_tree().change_scene_to_file("res://Scenes/level_scene.tscn") # back to intermission
		

func stardust_collect() -> void: # cool function that you connect to those stardust
	stardust_collected = stardust_collected + 1
	print("Stardust collected: ", stardust_collected)
	return
