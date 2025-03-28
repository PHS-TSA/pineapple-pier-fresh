extends Node3D

#update with dart
const DART = preload("res://ball.tscn")


func _on_dart_button_button_pressed(button):
	for i in range(len(%Darts.get_children())):
		%Darts.get_child(i).queue_free()
	
	#MOVE THIS SCRIPT TO MILK BOTTLE OBJECT CONTAINER
	
	# I should optimize this but state is in 2 weeks :) 
	
	for child in %DartMarkers.get_children():
		var dart = DART.instantiate()
		dart.position = child.position
		%Darts.add_child(dart)
	
