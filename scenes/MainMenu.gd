extends Control

func _ready():
	Sounds.play_music("Menu")

func _on_button_activate(button):
	if button == "exit":
		get_tree().quit()

func _on_SoundVolume_changed(value):
	Sounds.set_volume(value)
