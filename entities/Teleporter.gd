extends Area2D

export(NodePath) var postarget
export(String, FILE, "*.tscn") var scenetarget
export(bool) var emitting = true
export(bool) var returningtp = false

func _ready():
	get_node("Particles").emitting = emitting

func _on_entered(node):
	if !scenetarget or get_tree().change_scene(scenetarget) != OK:
		if postarget:
			node.position = get_node(postarget).position
			get_node("TeleportSound").play()
	else:
		Global.push({"returning_teleport": returningtp})
