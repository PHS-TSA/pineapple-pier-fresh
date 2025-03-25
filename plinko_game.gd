extends Node3D

const BALL = preload("res://ball.tscn")
var spawners


func _ready() -> void:
	spawners = %PlinkoBallSpawners.get_children()

func _on_plinko_button_button_pressed(button: Variant) -> void:
	var ball = BALL.instantiate()
	
	#LOOK FOR ERRORS HERE
	ball.position = spawners[randi_range(0,len(spawners)-1)].position
	
	%PlinkoBalls.add_child(ball)
	
	
	pass # Replace with function body.
