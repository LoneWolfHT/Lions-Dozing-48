extends Node2D

export(bool) var STARTED = false
export(bool) var REVERSE = false
export(float, 0.8, 60, 1.6) var INTERVAL = 1
export(int) var START_OFFSET = 0

const IMPLOSION_TIME = 0.7

var DEFAULT_MASK
var DID_IMPLOSION = false

func _ready():
	var bullet = get_node("Bullet")
	var bullet_area = bullet.get_node("BulletArea")

	DEFAULT_MASK = bullet_area.collision_mask

	bullet.visible = false
	bullet_area.collision_mask = 0

	var pop = Global.pop()
	if pop:
		REVERSE = pop
		Global.push(pop)

	if REVERSE:
		bullet.REVERSE = true

	for child in self.get_children():
		if child is Position2D:
			var implo = get_node("Implosion").duplicate()
			child.add_child(implo)

			if REVERSE:
				implo.radial_accel *= -1

func _boss_started():
	if START_OFFSET > 0:
		get_node("Timer").start(START_OFFSET)
	else:
		get_node("Timer").start(INTERVAL)

func _on_timeout():
	if START_OFFSET > 0: # Scene was just loaded a little bit ago
		START_OFFSET = 0
		get_node("Timer").start(INTERVAL-IMPLOSION_TIME)
		return

	if !DID_IMPLOSION: # Going to send a bullet soon
		DID_IMPLOSION = true
		get_node("Timer").start(IMPLOSION_TIME) # wait this long until sending bullet

		if !REVERSE:
			get_node("ImplosionSound").play()

			for child in self.get_children():
				if child is Position2D:
					child.get_node("Implosion").emitting = true

		return
	else: # Time to send a bullet
		if !REVERSE:
			for child in self.get_children():
				if child is Position2D:
					child.get_node("Implosion").emitting = false

		print(INTERVAL-IMPLOSION_TIME)
		get_node("Timer").start(INTERVAL-IMPLOSION_TIME) # Wait this long until next pre-bullet implosion

		if !REVERSE:
			get_node("BulletSound").play()
		else:
			get_node("BulletHitSound").play()


		DID_IMPLOSION = false

	for child in self.get_children():
		if child is Position2D:
			var bullet = get_node("Bullet")
			var newbullet = bullet.duplicate()

			newbullet.REVERSE = REVERSE
			add_child(newbullet)

			newbullet.get_node("BulletArea").collision_mask = DEFAULT_MASK
			newbullet.visible = true
			newbullet.scale = Vector2(2, 2)

			if !REVERSE:
				newbullet.position = child.position
				newbullet.linear_velocity = child.position.direction_to(self.position) * 300
			else:
				newbullet.position = self.position
				newbullet.linear_velocity = self.position.direction_to(child.position) * 300

