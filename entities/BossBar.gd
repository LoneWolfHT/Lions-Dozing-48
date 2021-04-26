extends ProgressBar

export(NodePath) var BOSS
export(Array, NodePath) var START_TRIGGERS
export(Array, NodePath) var DEATH_TRIGGERS
export(bool) var REVERSE = false

signal on_boss_start
signal on_boss_death

var STARTED = false
var STOP = false

func _ready():
	self.visible = false

	var pop = Global.pop()
	if pop:
		REVERSE = pop
		Global.push(pop)

	assert(BOSS, "You have to link the healthbar to a boss!")
	for nodepath in START_TRIGGERS:
		assert(self.connect("on_boss_start", get_node(nodepath), "_on_boss_start") == OK)
	for nodepath in DEATH_TRIGGERS:
		assert(self.connect("on_boss_death", get_node(nodepath), "_on_boss_death") == OK)

func _process(_delta):
	if STOP:
		return

	self.value = get_node(BOSS).HEALTH

	if !REVERSE:
		if !STARTED && self.value > 0:
			self.visible = true
			STARTED = true
			emit_signal("on_boss_start")

		if self.value >= self.max_value:
			emit_signal("on_boss_death")
			STOP = true
	else:
		if !STARTED && self.value == self.max_value:
			self.visible = true
			STARTED = true
			emit_signal("on_boss_start")

		if self.value <= 0:
			emit_signal("on_boss_death")
			STOP = true
			get_node(BOSS).queue_free()
			queue_free()
