extends Node2D
@onready var player: CharacterBody2D = $"../player" # grabs the parent node
@onready var self_area = $Area2D
@onready var player_area = $"../player/Area2D"

# make a signal
signal garlic_collected

func _process(delta: float) -> void: # this runs EVERY FRAME! 
	
	if player_area.overlaps_area(self_area): # checks if overlapping
		if self.visible:
			emit_signal("garlic_collected") #signal broadcast
			self.hide() #removed from player sight; collected
		
