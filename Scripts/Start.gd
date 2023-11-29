extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	Bgm.stream = load("res://assets/sound/gunfight.mp3")
	Bgm.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_btn_button_up():
	ClickSound.stream = load("res://assets/sound/reload2.wav")
	ClickSound.play()
	Global.player_type = 1
	get_tree().change_scene_to_file("res://Scenes/Select.tscn")
	pass # Replace with function body.


func _on_texture_button_button_up():
	print('hi')
	pass # Replace with function body.
