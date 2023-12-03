extends CanvasLayer

var p1 = preload("res://assets/img/portrait1.png")
var p2 = preload("res://assets/img/portrait2.png")
var p3 = preload("res://assets/img/portrait3.png")

var gametime
var game
var minute
var second
@onready var HP = $Hp_bar
@onready var EXP = $Exp_bar
@onready var SHIELD = $Shield_bar
@onready var FIRE = $Fire_bar
@onready var HPV = $HP
@onready var ATK = $ATK
@onready var SPD = $SPD
@onready var MINUTE = $MINUTE
@onready var SECOND = $SECOND
@onready var SCORE = $SCORE
@onready var LEVEL = $Lv

func _ready():
	await get_tree().get_root().get_node("World").ready
	game = get_tree().get_root().get_node("World")
	
	$portrait.set_texture([p1, p2, p3][Global.player_type - 1])
	
	HP.max_value = game.player_hp
	EXP.max_value = game.player_need_exp
	FIRE.max_value = game.fire_duration
	LEVEL.text = str(game.player_level)
	ATK.text = str(game.player_atk)
	SPD.text = "%.1f" % (game.player_speed * 0.01)
	gametime = 0
	
	if Global.player_type == 2:
		SHIELD.visible = true
		SHIELD.max_value = game.player_shield_timer_MAX
	

func _process(delta):
	gametime += delta
	
	second = fmod(gametime, 60)
	minute = fmod(gametime, 3600) / 60
	
	SECOND.text = "%02d" % second
	MINUTE.text = "%02d" % minute
	HPV.text = str(game.player_hp) + "/" + str(game.player_max_hp)
	
	ATK.text = str(game.player_atk)
	SPD.text = "%.1f" % (game.player_speed * 0.01)
	
	LEVEL.text = str(game.player_level)
	EXP.max_value = game.player_need_exp
	
	HP.value = game.player_hp
	HP.max_value = game.player_max_hp
	
	EXP.value = game.player_exp
	SCORE.text = str(game.score)
	
	FIRE.max_value = game.fire_duration
	FIRE.value = game.fire_duration - game.FireTimer.get_time_left()
	
	SHIELD.value = game.player_shield_timer_MAX - game.PlayerShieldTimer.get_time_left()


func _result():
	return MINUTE.text + " : " + SECOND.text
