extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_scene = load("res://enemy.tscn")
	new_enemy()

func new_enemy():
	var enemy
	enemy = enemy_scene.instance()
	$enemy_path.add_child(enemy)
