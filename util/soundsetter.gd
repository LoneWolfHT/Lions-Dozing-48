extends Node

export(int) var offset = -8

func _ready():
	self.volume_db = Sounds.get_volume() + offset
