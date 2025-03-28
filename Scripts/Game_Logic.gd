extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	#if(body.name == "PlayerBody"):
	if(body.name == "PlayerBody"):
		print(%XROrigin3D.global_position)
		%XROrigin3D.set_global_position(Vector3(0,0,0)) 
		print(%XROrigin3D.global_position)
