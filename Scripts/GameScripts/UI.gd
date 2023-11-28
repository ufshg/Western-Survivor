extends CanvasLayer

var game
@onready var hp_bar = $Hp_bar
@onready var atk = $ATK
@onready var spd = $SPD

func _ready():
	await get_tree().get_root().get_node("World").ready
	game = get_tree().get_root().get_node("World")
	
	hp_bar.max_value = game.player_hp
	atk.text = str(game.player_atk)
	spd.text = str(game.player.speed)
	

func _process(delta):
	hp_bar.value = game.player_hp
	pass
