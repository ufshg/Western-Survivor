extends Sprite2D

var p1 = preload("res://assets/img/player1_right.png")
var p2 = preload("res://assets/img/player2_right.png")
var p3 = preload("res://assets/img/player3_right.png")

var arr

# Called when the node enters the scene tree for the first time.
func _ready():
	arr = [
		[$Rank1/Player, $Rank1/Name, $Rank1/Time, $Rank1/Score],
		[$Rank2/Player, $Rank2/Name, $Rank2/Time, $Rank2/Score],
		[$Rank3/Player, $Rank3/Name, $Rank3/Time, $Rank3/Score],
		[$Rank4/Player, $Rank4/Name, $Rank4/Time, $Rank4/Score],
		[$Rank5/Player, $Rank5/Name, $Rank5/Time, $Rank5/Score],
	]
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func init(json):
	var holder = "@/*/@"
	var types = json["types"].split(holder)
	var names = json["names"].split(holder)
	var times = json["times"].split(holder)
	var scores = json["scores"].split(holder)
	
	var length = len(types)
	
	for i in range(length):
		arr[i][0].set_texture([p1, p2, p3][int(types[i]) - 1])
		arr[i][1].text = names[i]
		arr[i][2].text = times[i]
		arr[i][3].text = scores[i]
	
	self.visible = true
	
	pass


func _on_back_btn_button_up():
	$BackBtn.set_scale(Vector2(1, 1))	
	self.visible = false
	pass # Replace with function body.


func _on_back_btn_mouse_entered():
	$BackBtn.set_scale(Vector2(1.1, 1.1))
	pass # Replace with function body.


func _on_back_btn_mouse_exited():
	$BackBtn.set_scale(Vector2(1, 1))
	pass # Replace with function body.
