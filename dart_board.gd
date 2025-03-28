extends Node3D

const BALLOON = preload("res://balloon2.tscn")
const DART = preload("res://dart.tscn")
const TROPHY = preload("res://pineapple-trophy-pickable.tscn")


'''
How to finish this:
implement button that spawns 4 balls
everytime user presses it respawn the balls unless wonGame = true. Then reset dart board

'''

#This implementation is terrible but i want to go to bed
var balloonsLeft
var winningBalloon
var playerWin = false

func _ready():
	#%Balloon.get_child(0).mesh.material.albedo_color = Color(255,255,00)
	spawnBalloons()
	

func spawnBalloons():
	var i = 0
	for child in %BalloonMarkers.get_children():
		var balloon = BALLOON.instantiate()
		balloon.position = child.position
		balloon.rotate_x(90)
		balloon.name = ("Balloon"+ str(i))
		%Balloons2.add_child(balloon)
		i+=1
	winningBalloon = randi_range(0,len(%BalloonMarkers.get_children())-1)
	%WinningPineappleSprite.position = %BalloonMarkers.get_children()[winningBalloon].position
	balloonsLeft = len(%Balloons2.get_children())
	
	for child in %Balloons2.get_children():	
		
		var material = child.get_child(0).get_surface_override_material(0).duplicate()
		var r = randi_range(0,255) / 255.0
		var g = randi_range(0,255) / 255.0
		var b = randi_range(0,255) / 255.0
		material.albedo_color = Color(r, g, b)
		child.get_child(0).set_surface_override_material(0, material)
	


func _on_dart_button_button_pressed(button):
	if(playerWin == true):
		print(playerWin)
		playerWin = false
		print(playerWin)
		%DartWinLabel.visible = false
		%InGameLabels.visible = true
		spawnBalloons()
		
		
	for i in range(len(%Darts.get_children())):
		%Darts.get_child(i).queue_free()
	
	#MOVE THIS SCRIPT TO MILK BOTTLE OBJECT CONTAINER
	
	# I should optimize this but state is in 2 weeks :) 
	
	for child in %DartMarkers.get_children():
		var dart = DART.instantiate()
		dart.position = child.position
		dart.rotate_y(PI/2)
		%Darts.add_child(dart)

func _process(delta):
	#may god have mercy on my soul for this if statement. TODO rework this pimp
	if(len(%Balloons2.get_children()) < balloonsLeft):
		%PopSound.play()
		balloonsLeft = len(%Balloons2.get_children())
		var winningBalloonNode = %Balloons2.get_node_or_null("Balloon" + str(winningBalloon))
		if winningBalloonNode == null:
			print("You popped the winning balloon!")
			%InGameLabels.visible = false
			%DartWinLabel.visible = true
			playerWin = true
			%DartConfetti.emitting = true
			%DartYay.play()
			await get_tree().create_timer(0.5).timeout
			%DartConfetti.emitting = false
			
			#Make button green
			var material = %DartButtonMesh.get_surface_override_material(0).duplicate()
			if(material.albedo_color != Color(0,255,0)):
				Global.gamesWon +=1
				if(Global.gamesWon == 4 and not Global.trophySpawned):
					print("all games completed spawning trophy")
					var trophy = TROPHY.instantiate()
					trophy.position = %TrophyMarker.position
					self.get_tree().root.add_child(trophy)
					Global.trophySpawned = false
			material.albedo_color = Color(0,255,0)
			%DartButtonMesh.set_surface_override_material(0, material)
			
			
			
			# Add your win condition logic here
	
