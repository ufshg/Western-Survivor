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
	]
	
	pass # Replace with function body.


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
	
	$MyRank/Player.set_texture([p1, p2, p3][Global.player_type - 1])
	$MyRank/Name.text = Global.player_name
	$MyRank/Time.text = Global.result_time
	$MyRank/Score.text = str(Global.result_score)
	$MyRank/Grade.text = str(json["my_rank"])
	
	self.visible = true
	
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
