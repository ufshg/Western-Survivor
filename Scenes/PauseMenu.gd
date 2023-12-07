extends Panel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_resume_btn_button_up():
	ClickSound.stream = load("res://assets/sound/item.mp3")
	ClickSound.play()
	get_node("/root/World")._Resume()
	pass # Replace with function body.


func _on_resume_btn_mouse_entered():
	$ResumeBtn.set_scale(Vector2(0.27, 0.27))
	$ResumeBtn.position += Vector2(-12, -6)
	pass # Replace with function body.


func _on_resume_btn_mouse_exited():
	$ResumeBtn.set_scale(Vector2(0.25, 0.25))
	$ResumeBtn.position += Vector2(12, 6)
	pass # Replace with function body.


func _on_go_main_btn_button_up():
	ClickSound.stream = load("res://assets/sound/item.mp3")
	ClickSound.play()
	get_node("/root/World")._Resume()
	DisplayServer.mouse_set_mode(DisplayServer.MOUSE_MODE_VISIBLE)
	get_tree().change_scene_to_file("res://Scenes/Start.tscn")
	pass # Replace with function body.


func _on_go_main_btn_mouse_entered():
	$GoMainBtn.set_scale(Vector2(0.27, 0.27))
	$GoMainBtn.position += Vector2(-12, -6)
	pass # Replace with function body.


func _on_go_main_btn_mouse_exited():
	$GoMainBtn.set_scale(Vector2(0.25, 0.25))
	$GoMainBtn.position += Vector2(12, 6)
	pass # Replace with function body.
