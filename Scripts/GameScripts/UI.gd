extends CanvasLayer

var p1 = preload("res://assets/img/portrait1.png")
var p2 = preload("res://assets/img/portrait2.png")
var p3 = preload("res://assets/img/portrait3.png")

var s1 = preload("res://assets/img/attack_icon.png")
var s2 = preload("res://assets/img/speed_icon.png")
var s3 = preload("res://assets/img/stew_icon.png")
var s4 = preload("res://assets/img/whisky_icon.png")

var gametime
var game
var minute
var second
var slotarr
var slottex
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

@onready var SLOT1 = $Slot1
@onready var SLOT2 = $Slot2
@onready var SLOT3 = $Slot3
@onready var SLOT4 = $Slot4

@onready var BOSS = $Boss_hp
@onready var BOSSNAME = $BossName
@onready var BOSSHP = $BossHpText
var boss

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
	slotarr = []
	slottex = [s1, s2, s3, s4]
	
	if Global.player_type == 2:
		SHIELD.visible = true
		SHIELD.max_value = game.player_shield_timer_MAX
	
	# boss check = False
	boss = false
	

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
	
	if boss:
		BOSS.value = game.boss_instance.hp
		BOSSHP.text = str(game.boss_instance.hp)


func _result():
	return MINUTE.text + ":" + SECOND.text
	

func _slot_set(number):
	# is the number of item already exist?
	if number in slotarr:
		return
		
	var temp = [SLOT1, SLOT2, SLOT3, SLOT4]
	
	# slot index = slotarr length before add number
	var idx = len(slotarr)
	slotarr.append(number)
	
	temp[idx].set_texture(slottex[number])
	
	# if item is stew, y pos += 1
	if number == 2:
		temp[idx].position += Vector2(0, 1)
	
	temp[idx].visible = true


func boss_init():
	BOSS.max_value = game.boss_instance.hp_max
	BOSS.value = game.boss_instance.hp
	boss = true
	BOSS.visible = true
	BOSSNAME.visible = true
	BOSSHP.visible = true


func boss_end():
	BOSS.visible = false
	BOSSNAME.visible = false
	BOSSHP.visible = false
	BOSS.max_value = 1
	BOSS.value = 1
	boss = false
