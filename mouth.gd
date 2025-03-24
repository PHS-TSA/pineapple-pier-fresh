extends Area3D


func _on_body_entered(body):
	print("collisions work")
	print(body)
	print(body.scene_file_path)
	if(body.scene_file_path == "res://hotdog.tscn"):
		print("collisions extra work")
		body.queue_free()
