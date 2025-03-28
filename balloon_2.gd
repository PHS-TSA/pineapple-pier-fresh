extends Node3D


func _on_area_3d_body_entered(body):
	if(body.scene_file_path == "res://dart.tscn"):
		%PopSound.play()
		self.queue_free()
		body.queue_free()
