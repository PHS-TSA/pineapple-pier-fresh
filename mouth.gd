extends Area3D


func _on_body_entered(body):
	if(body.scene_file_path == "res://hotdog.tscn"):
		%MunchSound.play()
		print(body.get_parent())
		body.get_parent().remove_child(body)
		
		
