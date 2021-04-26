extends RigidBody2D

export(bool) var REVERSE = false
var POST_DEATH_SCENE
var POST_RETURN_DEATH_SCENE

func _on_collide(node):
	if node.name == "Player":
		var timer = get_node("NewGameTimer")

		timer.start(1)
		POST_DEATH_SCENE = node.POST_DEATH_SCENE
		POST_DEATH_SCENE = node.POST_DEATH_SCENE
		get_tree().paused = true
		return
	elif REVERSE && node.name =="Boss":
		return

	if !REVERSE:
		get_parent().get_node("BulletHitSound").play()
	else:
		get_parent().get_node("BulletSound").play()


	queue_free()

func _on_NewGameTimer_timeout():
	get_tree().paused = false
	get_tree().change_scene(POST_DEATH_SCENE)
