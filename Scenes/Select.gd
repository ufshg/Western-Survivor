extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_player_1_button_up():
	ClickSound.stream = load("res://assets/sound/item.mp3")
	ClickSound.volume_db = 0
	ClickSound.play()
	Global.player_type = 1
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pass # Replace with function body.


func _on_player_2_button_up():
	ClickSound.stream = load("res://assets/sound/item.mp3")
	ClickSound.volume_db = 0
	ClickSound.play()
	Global.player_type = 2	
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")	
	pass # Replace with function body.


func _on_player_3_button_up():
	ClickSound.stream = load("res://assets/sound/item.mp3")
	ClickSound.volume_db = 0
	ClickSound.play()
	Global.player_type = 3
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pass # Replace with function body.
