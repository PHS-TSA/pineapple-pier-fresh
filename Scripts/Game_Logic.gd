extends Node3D


func _on_area_3d_body_entered(body: Node3D) -> void:
	if(body.name == "XROrigin3D"):
		%XROrigin3D.global_position = %Spawn.global_position
