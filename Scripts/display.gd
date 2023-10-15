extends Label


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _get_this():
	return get_node("/root/Start/display")


func _get_this_text_to_int():
	return int(_get_this().text)


func _on_Button_button_up():
	Global.player_type = 1
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pass # Replace with function body.


func _on_Button2_button_up():
	Global.player_type = 2
	get_tree().change_scene_to_file("res://Scenes/Game.tscn")
	pass # Replace with function body.

