extends KinematicBody2D

export(bool) var ENABLED = true
export(String, FILE, "*.tscn") var POST_DEATH_SCENE
export(int) var WALK_SPEED = 250
export(float, -100, 100, 0.1) var DAMAGE = 2
export(String, "Idle", "Walk", "Attack", "Dead") var INITIAL_ANIMATION = "Idle"

var ATTACKING = false
var BOSS_IN_RANGE = false
var BOSS_ATTACKED = false

func _ready():
	if !ENABLED:
		get_node("Camera").current = false
		get_node("Collision").disabled = true

	get_node("Anim").animation = INITIAL_ANIMATION

func _physics_process(_delta):
	if !ENABLED:
		return

	var velocity = Vector2()

	if Input.is_action_pressed("move_left"):
		velocity.x = -WALK_SPEED
	elif Input.is_action_pressed("move_right"):
		velocity.x = WALK_SPEED
	if Input.is_action_pressed("move_up"):
		velocity.y = -WALK_SPEED
	elif Input.is_action_pressed("move_down"):
		velocity.y = WALK_SPEED

	if !ATTACKING && Input.is_action_pressed("attack"):
		get_node("Anim").speed_scale = 1.7
		get_node("Swoosh").play()
		ATTACKING = true
		BOSS_ATTACKED = false
	else:
		if !BOSS_ATTACKED:
			if BOSS_IN_RANGE:
				BOSS_ATTACKED = true
				BOSS_IN_RANGE.HEALTH += DAMAGE
				get_node("HitMetal").play()

	handle_anims(velocity.normalized())
	velocity = move_and_slide(velocity, Vector2(), false, 2)


func _anim_finished():
	if ATTACKING:
		get_node("Anim").speed_scale = 1
		ATTACKING = false

func handle_anims(dir):
	var anim = get_node("Anim")

	if ATTACKING:
		anim.playing = true
		anim.animation = "Attack"
	elif anim.animation != INITIAL_ANIMATION || dir.length() > 0:
		anim.playing = true
		anim.animation = "Walk"

	if dir.length() > 0:
		self.rotation = atan2(dir.y, dir.x) + deg2rad(90)
	elif !ATTACKING:
		anim.playing = false


func _on_StabArea_entered(area):
	var entity = area.get_parent()

	if entity.name == "Boss":
		BOSS_IN_RANGE = entity

func _on_StabArea_exited(area):
	if area.get_parent().name == "Boss":
		BOSS_IN_RANGE = false
