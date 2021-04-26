extends Node2D

var playing
var volume = -10

func play_music(name = null):
	if playing == name:
		return

	if playing:
		get_node(playing).stop()
		playing = null

	if name:
		var music = get_node(name)
		music.play()
		music.volume_db = volume
		playing = name

func stop_music():
	if playing:
		get_node(playing).stop()
		playing = null

func set_volume(val):
	volume = val

	if playing:
		get_node(playing).volume_db = volume

func get_volume():
	return volume
