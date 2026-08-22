extends Node2D

@onready var player: CharacterBody2D = $"../Player"
@onready var self_area = $Area2D
@onready var player_area = $"../Player/Area2D"

signal garlic_collected

func _process(delta: float) -> void:
	if player_area.overlaps_area(self_area):
		if self.visible:
			emit_signal("garlic_collected")
			self.hide()
