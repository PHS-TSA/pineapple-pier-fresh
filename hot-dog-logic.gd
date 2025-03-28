extends Node3D

var buttonPress:bool = false
const HOTDOG = preload("res://hotdog.tscn")
const TROPHY = preload("res://pineapple-trophy-pickable.tscn")

var played = false
var playerWin:bool


func _process(delta):
	
	if(buttonPress):
		if(%ContestTimer.time_left > 0):
			# Assuming you're using a Label3D node for text display in 3D space
			%HotDogTimerLabel.text = str(int(%ContestTimer.time_left))
		else:
			#Add in losing sad horn
			%ContestTimer.stop()
			buttonPress = false
			playerWin = false
			#Sad trombone here
			for child in %HotDogs.get_children():
				child.queue_free()
		if(len(%HotDogs.get_children()) == 0):
			playerWin = true
			%ContestTimer.stop()
			%HotDogConfetti.emitting = true
			%HotDogYay.play()
			await get_tree().create_timer(0.5).timeout
			%HotDogSound.play()
			%HotDogConfetti.emitting = false
			
			%HotDogTimerLabel.text = "You Win!"
			
			#Green button
			
			var material = %HotDogButtonMesh.get_surface_override_material(0).duplicate()
			if(material.albedo_color != Color(0,255,0)):
				Global.gamesWon +=1
				if(Global.gamesWon == 4 and not Global.trophySpawned):
					print("all games completed spawning trophy")
					var trophy = TROPHY.instantiate()
					trophy.position = %TrophyMarker.position
					self.get_tree().root.add_child(trophy)
					Global.trophySpawned = false
			material.albedo_color = Color(0,255,0)
			%HotDogButtonMesh.set_surface_override_material(0, material)
			
	elif(not played):
		
		%HotDogTimerLabel.text = "Start 
		Contest?"
	elif playerWin:
		
		%HotDogTimerLabel.text = "You Win!"
	elif (not playerWin):
		
		%HotDogTimerLabel.text = "You Lost!"
	else:
		
		%HotDogTimerLabel.text = "Start 
		Contest?"
		

func _on_hot_dog_button_button_pressed(button):
	played = true
	for child in %HotDogs.get_children():
		child.queue_free()
	%StartingBell.play()
	%ContestTimer.start(30)
	buttonPress = true
	for child in %HotDogSpawners.get_children():
		var hotdog = HOTDOG.instantiate()
		hotdog.position = child.position
		%HotDogs.add_child(hotdog)
		
	pass # Replace with function body.
