extends Node


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var startBtn
var player_name

# Called when the node enters the scene tree for the first time.
func _ready():
	Bgm.stream = load("res://assets/sound/gunfight.mp3")
	Bgm.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_start_btn_button_up():
	if not player_name:
		return
	Global.player_name = player_name
	ClickSound.stream = load("res://assets/sound/reload2.wav")
	ClickSound.play()
	Global.player_type = 1
	get_tree().change_scene_to_file("res://Scenes/Select.tscn")
	pass # Replace with function body.


func _on_texture_button_button_up():
	pass # Replace with function body.


func _on_start_btn_mouse_entered():
	$StartBtn.set_scale(Vector2(0.42, 0.42))
	$StartBtn.position += Vector2(-6, -3)
	pass # Replace with function body.
	
	
func _on_start_btn_mouse_exited():
	$StartBtn.set_scale(Vector2(0.4, 0.4))
	$StartBtn.position += Vector2(6, 3)
	pass # Replace with function body.


func _on_input_box_text_changed(new_text):
	player_name = new_text
	print(player_name)


func _on_quit_btn_mouse_entered():
	$QuitBtn.set_scale(Vector2(0.42, 0.42))
	$QuitBtn.position += Vector2(-6, -3)
	pass # Replace with function body.


func _on_quit_btn_mouse_exited():
	$QuitBtn.set_scale(Vector2(0.4, 0.4))
	$QuitBtn.position += Vector2(6, 3)
	pass # Replace with function body.


func _on_quit_btn_button_up():
	JavaScriptBridge.eval("window.close()")
	pass # Replace with function body.
