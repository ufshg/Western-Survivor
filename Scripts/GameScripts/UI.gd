extends CanvasLayer

var gametime
var game
var minute
var second
@onready var HP = $Hp_bar
@onready var EXP = $Exp_bar
@onready var SHIELD = $Shield_bar
@onready var ATK = $ATK
@onready var SPD = $SPD
@onready var MINUTE = $MINUTE
@onready var SECOND = $SECOND
@onready var SCORE = $SCORE
@onready var LEVEL = $Lv

func _ready():
	await get_tree().get_root().get_node("World").ready
	game = get_tree().get_root().get_node("World")
	
	HP.max_value = game.player_hp
	EXP.max_value = game.player_need_exp
	LEVEL.text = str(game.player_level)
	ATK.text = str(game.player_atk)
	SPD.text = "%.1f" % (game.player.speed / 100)
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
	
	LEVEL.text = str(game.player_level)
	EXP.max_value = game.player_need_exp
	
	HP.value = game.player_hp
	EXP.value = game.player_exp
	SCORE.text = str(game.score)
	
	SHIELD.value = game.player_shield_timer_MAX - game.PlayerShieldTimer.get_time_left()
