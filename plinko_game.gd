extends Node3D

const BALL = preload("res://plinko-ball.tscn")
var spawners
var ballsLeft = 10
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
			%BallsLeftLabel.text = str(ballsLeft)
			%PlinkoCurrent.text = ("Current: "+ str(currentScore))
#Have these connect to a different function and pass in body

#implement you win label that pops up if you win 
#If balls left = 0 and this runs and the player loses play something and activate reset button
func _on_area_body_entered(body, value): #20
	print(body)
	currentScore += value
	%PlinkoCurrent.text = ("Current: "+ str(currentScore))
	if(currentScore >= 500):
		print("winner winner chicken dinner!")
	#Losing Logic
	if(ballsLeft == 0):
		print("loser lmao")
		pauseOver = true
