extends Node

var t1 = preload("res://assets/img/player1_right.png")
var t2 = preload("res://assets/img/player2_right.png")
var t3 = preload("res://assets/img/player3_right.png")


# Called when the node enters the scene tree for the first time.
func _ready():
	$Character.set_texture([t1, t2, t3][Global.player_type - 1])
	#$PlayerName.text = Global.player_name
	$Time.text = Global.result_time
	$Score.text = Global.result_score
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	pass


func _on_register_btn_mouse_entered():
	$RegisterBtn.set_scale(Vector2(0.42, 0.42))
	$RegisterBtn.position += Vector2(-6, -3)
	pass # Replace with function body.


func _on_register_btn_mouse_exited():
	$RegisterBtn.set_scale(Vector2(0.4, 0.4))
	$RegisterBtn.position += Vector2(6, 3)
	pass # Replace with function body.


func _on_register_btn_button_up():
	print("NOPE")
	pass # Replace with function body.


func _on_retry_btn_mouse_entered():
	$RetryBtn.set_scale(Vector2(0.42, 0.42))
	$RetryBtn.position += Vector2(-6, -3)
	pass # Replace with function body.


func _on_retry_btn_mouse_exited():
	$RetryBtn.set_scale(Vector2(0.4, 0.4))
	$RetryBtn.position += Vector2(6, 3)
	pass # Replace with function body.


func _on_retry_btn_button_up():
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")
	pass # Replace with function body.


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

