extends Node2D

func _ready():
	var returning_teleport = Global.pop()

	Sounds.play_music("Background")

	if returning_teleport:
		var player = get_node("Player")

		player.position = get_node("ReturnSpawn").position
		player.DAMAGE = -10
		get_node("Teleport").play()
		get_node("Label").text = "To be continued...\nI ran out of time. But I hope this game was plenty playable for you anyway.\nLook for a post-jam version. For now you can go back to the start of this room, go back through the portal to the house, and try the boss fight a few more times, or you can head past the house to exit to the main menu.\nThanks for playing!"
