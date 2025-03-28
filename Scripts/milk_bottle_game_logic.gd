extends Node3D

const MILKBALL = preload("res://ball.tscn")
const MILKBOTTLE = preload("res://milk_bottle.tscn")

var bottles: Array[RigidBody3D]
#TODO
#Implement ready function to get all starting bottles 

func _ready():
	for i in range(len(self.get_children())):
		if(self.get_child(i).scene_file_path == "res://milk_bottle.tscn"):
				bottles.append(self.get_child(i).get_child(0))


#TODO please optimize this brosif. you know gdscript now
func _on_milk_button_button_pressed(button):
	%MilkTimer.stop()
	
	
	for i in range(len(self.get_children())):
		self.get_child(i).queue_free()
	
	#MOVE THIS SCRIPT TO MILK BOTTLE OBJECT CONTAINER
	
	# I should optimize this but state is in 2 weeks :) 
	var ball1 = MILKBALL.instantiate()
	ball1.position = %Ball1Marker.position
	add_child(ball1)
	var ball2 = MILKBALL.instantiate()
	ball2.position = %Ball2Marker.position
	add_child(ball2)
	var ball3 = MILKBALL.instantiate()
	ball3.position = %Ball3Marker.position
	add_child(ball3)
	
	var bottle1 = MILKBOTTLE.instantiate()
	bottle1.position = %Milk1Marker.position
	add_child(bottle1)
	var bottle2 = MILKBOTTLE.instantiate()
	bottle2.position = %Milk2Marker.position
	add_child(bottle2)
	var bottle3 = MILKBOTTLE.instantiate()
	bottle3.position = %Milk3Marker.position
	add_child(bottle3)
	
	await get_tree().create_timer(0.1).timeout
	
	bottles.clear()
	for i in range(len(self.get_children())):
		
		
		if(self.get_child(i).scene_file_path == "res://milk_bottle.tscn"):
			bottles.append(self.get_child(i).get_child(0))
	
	

#func _physics_process(delta):
	
	



func _on_milk_area_body_entered(body):
	if(%MilkTimer.time_left == 0 && body.scene_file_path == "res://ball.tscn"):
		%MilkTimer.start(2)

	while(%MilkTimer.time_left > 0):
		var knockedOver = true
		# I was going to write this better but I thought it'd be funnier to have eli review this. Introducing the if statement from hell
		
		for bottle in bottles:
			if(abs(bottle.rotation_degrees.x) < 40 && abs(bottle.rotation_degrees.z) < 40):
				knockedOver = false
		if(knockedOver):
			%MilkTimer.stop()
			%MilkConfetti.emitting = true
			%MilkYay.play()
			await get_tree().create_timer(0.5).timeout
			%MilkConfetti.emitting = false

			break
		await get_tree().create_timer(0.1).timeout

	pass # Replace with function body.
