extends Node3D

const BALL = preload("res://plinko-ball.tscn")
const TROPHY = preload("res://pineapple-trophy-pickable.tscn")
var spawners
var ballsLeft = 10
var ballEntered = 0
var currentScore = 0
var pauseOver = true

func _ready() -> void:
	spawners = %PlinkoBallSpawners.get_children()
	%BallsLeftLabel.text = str(ballsLeft)
	%PlinkoCurrent.text = ("Current: "+ str(currentScore))
	


#add in a reset button next to this one
func _on_plinko_button_button_pressed(button: Variant) -> void:
	if(ballsLeft>0):
		var ball = BALL.instantiate()
		ball.position = spawners[randi_range(0,len(spawners)-1)].position
		%PlinkoBalls.add_child(ball)
		ballsLeft -= 1
		%BallsLeftLabel.text = str(ballsLeft)
		
		#Disable button for 6 seconds so player sees if they win
		if(ballsLeft==0):
			pauseOver = false
			
	else:
		#reset logic
		if(pauseOver):
			for child in %PlinkoBalls.get_children():
				child.queue_free()
			ballsLeft = 10
			currentScore = 0
			ballEntered = 0
			%WinLoseLabel.visible = false
			%BallsLeftLabel.text = str(ballsLeft)
			%PlinkoCurrent.text = ("Current: "+ str(currentScore))
#Have these connect to a different function and pass in body

#implement you win label that pops up if you win 
#If balls left = 0 and this runs and the player loses play something and activate reset button
func _on_area_body_entered(body, value):
	currentScore += value
	ballEntered += 1
	%PlinkoCurrent.text = ("Current: "+ str(currentScore))
	if(currentScore >= 400):
		%WinLoseLabel.text = "You Win!"
		%WinLoseLabel.visible = true
		%PlinkoConfetti.emitting = true
		%PlinkoYay.play()
		await get_tree().create_timer(0.5).timeout
		%PlinkoConfetti.emitting = false
		await get_tree().create_timer(4).timeout
		pauseOver = true
		
		var material = %PlinkoButtonMesh.get_surface_override_material(0).duplicate()
		if(material.albedo_color != Color(0,255,0)):
				Global.gamesWon +=1
				if(Global.gamesWon == 4 and not Global.trophySpawned):
					print("all games completed spawning trophy")
					var trophy = TROPHY.instantiate()
					trophy.position = %TrophyMarker.position
					self.get_tree().root.add_child(trophy)
					Global.trophySpawned = false
		material.albedo_color = Color(0,255,0)
		%PlinkoButtonMesh.set_surface_override_material(0, material)
	
	#Losing Logic
	elif(ballsLeft == 0 and ballEntered == 10):
		%WinLoseLabel.text = "You Lose!
		Press the button 
		to play again!"
		%WinLoseLabel.visible = true
		pauseOver = true
