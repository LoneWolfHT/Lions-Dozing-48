extends StaticBody2D

export(int) var HEALTH = 0
export(bool) var REVERSE = false
export(Array, NodePath) var START_ADD_NODES
export(Array, NodePath) var DEATH_REMOVE_NODES

signal boss_started

func _ready():
	var pop = Global.pop()
	if pop:
		REVERSE = pop
		Global.push(pop)

	if REVERSE:
		HEALTH = 100

	for child in get_children():
		if child.is_in_group("bullet_launcher"):
			self.connect("boss_started", child, "_boss_started")

func _on_boss_start():
	emit_signal("boss_started")

	Sounds.stop_music()
	get_node("BossMusic").play()

	if !REVERSE:
		for node in START_ADD_NODES:
			node = get_node(node)

			node.collision_layer = 1
			node.visible = true
	else:
		for node in DEATH_REMOVE_NODES:
			get_node(node).queue_free()

func _on_boss_death():
	get_node("BossMusic").stop()
	Sounds.play_music("Background")

	for child in get_children():
		if child.is_in_group("bullet_launcher"):
			child.get_node("Timer").stop()
			if !REVERSE:
				for childofchild in child.get_children():
					if childofchild is Position2D:
						childofchild.get_node("Implosion").emitting = false

	if REVERSE:
		for node in START_ADD_NODES:
			get_node(node).queue_free()
	else:
		for node in DEATH_REMOVE_NODES:
			get_node(node).queue_free()

