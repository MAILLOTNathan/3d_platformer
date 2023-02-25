extends Control

onready var life = $health
onready var coins = $credits
var stat = Stats

func _physics_process(delta):
	coins.text = str(stat.coins)
	life.text = str(stat.health)
