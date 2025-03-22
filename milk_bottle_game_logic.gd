extends Node3D

const MILKBALL = preload("res://ball.tscn")
const MILKBOTTLE = preload("res://milk_bottle.tscn")

var bottles = []
#TODO
#Implement ready function to get all starting bottles 

func _ready():
	for i in range(len(self.get_children())):
		if(self.get_child(i).scene_file_path == "res://milk_bottle.tscn"):
				bottles.append(self.get_child(i))

func _on_milk_button_button_pressed(button):
	print(bottles)
	print("started running")
	for i in range(len(self.get_children())):
		self.get_child(i).queue_free()
	
	#MOVE THIS SCRIPT TO MILK BOTTLE OBJECT CONTAINER
	
	# I should optimize this but state is in 2 weeks :) 
	var ball1 = MILKBALL.instantiate()
	ball1.global_position = %Ball1Marker.global_position
	add_child(ball1)
	var ball2 = MILKBALL.instantiate()
	ball2.global_position = %Ball2Marker.global_position
	add_child(ball2)
	var ball3 = MILKBALL.instantiate()
	ball3.global_position = %Ball3Marker.global_position
	add_child(ball3)
	
	var bottle1 = MILKBOTTLE.instantiate()
	bottle1.global_position = %Milk1Marker.global_position
	add_child(bottle1)
	var bottle2 = MILKBOTTLE.instantiate()
	bottle2.global_position = %Milk2Marker.global_position
	add_child(bottle2)
	var bottle3 = MILKBOTTLE.instantiate()
	bottle3.global_position = %Milk3Marker.global_position
	add_child(bottle3)
	print("stuff should be spawned")
	
	await get_tree().create_timer(0.5).timeout
	
	bottles.clear()
	for i in range(len(self.get_children())):
		print(self.get_child(i).scene_file_path)
		if(self.get_child(i).scene_file_path == "res://milk_bottle.tscn"):
			bottles.append(self.get_child(i))
	print(bottles)

#func _physics_process(delta):
	
	
