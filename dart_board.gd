extends Node3D

const BALLOON = preload("res://balloon2.tscn")

func _ready():
	#%Balloon.get_child(0).mesh.material.albedo_color = Color(255,255,00)
	for child in %BalloonMarkers.get_children():
		var balloon = BALLOON.instantiate()
		balloon.position = child.position
		balloon.rotate_x(90)
		%Balloons2.add_child(balloon)
	
	for child in %Balloons2.get_children():	
		print(child.get_child(0))
		var material = child.get_child(0).get_surface_override_material(0).duplicate()
		var r = randi_range(0,255) / 255.0
		var g = randi_range(0,255) / 255.0
		var b = randi_range(0,255) / 255.0
		material.albedo_color = Color(r, g, b)
		child.get_child(0).set_surface_override_material(0, material)
