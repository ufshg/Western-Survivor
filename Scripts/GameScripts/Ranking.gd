extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	ClickSound.stream = load("res://assets/sound/item.mp3")
	ClickSound.volume_db = 0
	ClickSound.play()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_http_request_request_completed(result, response_code, headers, body):
	pass # Replace with function body.


func _on_back_btn_button_up():
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")
	pass # Replace with function body.


func _on_back_btn_mouse_entered():
	$BackBtn.set_scale(Vector2(0.42, 0.42))
	$BackBtn.position += Vector2(-6, -3)
	pass # Replace with function body.


func _on_back_btn_mouse_exited():
	$BackBtn.set_scale(Vector2(0.4, 0.4))
	$BackBtn.position += Vector2(6, 3)
	pass # Replace with function body.
