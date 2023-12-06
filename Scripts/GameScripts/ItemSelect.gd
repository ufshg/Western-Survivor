extends Panel

var arr
var btn
var number

var excep

# Called when the node enters the scene tree for the first time.
func _ready():
	'''
	item 1 = ATK UP
	item 2 = Speed UP
	item 3 = Max hp UP
	item 4 = fire duration down
	
	[preload tex, scale, item name, item discription]
	'''
	
	arr = []
	
	arr.append(
		[preload("res://assets/img/attack_power.png"), 1.5, "총알", "\"강력해진 대화 수단\"\n\n\n\n공격력 2 증가"]
	)
	arr.append(
		[preload("res://assets/img/speed_up.png"), 1.5, "장화", "\"가볍고 질긴 가죽부츠\"\n\n\n\n이동속도 0.3 증가"]
	)
	arr.append(
		[preload("res://assets/img/stew.png"), 0.6, "스튜", "\"따뜻한 스튜 한 그릇\"\n\n\n\n최대 체력 20 증가"]
	)
	arr.append(
		[preload("res://assets/img/item_whisky.png"), 0.6, "위스키", "\"위스키, 언제나 좋은 친구\"\n\n\n\n발사 주기 감소"]
	)
	
	btn = []
	
	btn.append($Item1)
	btn.append($Item2)
	btn.append($Item3)
	
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func init(something):
	number = []
	excep = something
	var idx = 0
	for i in range(4):
		if i == excep:continue
		btn[idx].get_node("Sprite2D").set_texture(arr[i][0])
		btn[idx].get_node("Sprite2D").set_scale(Vector2(arr[i][1], arr[i][1]))
		btn[idx].get_node("Panel").text = arr[i][3]
		number.append(i)
		idx += 1


func _on_item_1_button_up():
	get_node("/root/World")._item_select_handler(number[0])
	pass # Replace with function body.


func _on_item_2_button_up():
	get_node("/root/World")._item_select_handler(number[1])
	pass # Replace with function body.


func _on_item_3_button_up():
	get_node("/root/World")._item_select_handler(number[2])
	pass # Replace with function body.
