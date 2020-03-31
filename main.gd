extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_scene
var enemies

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_scene = load("res://enemy.tscn")
	enemies = []
	new_enemy()

func _process(delta):
	# get_all_enemies_within(Vector2(300,100),100)
	pass 

# function for testing purposes; will update later
func new_enemy():
	var enemy
	enemy = enemy_scene.instance()
	$enemy_path.add_child(enemy)
	enemies.append(enemy)

# input: none
# output: array of all enemies
func get_all_enemies():
	return enemies

# input: Vector2, float
# output: array of enemies within radius of the center
func get_all_enemies_within(center, radius):
	var t = []
	for e in enemies:
		if e.position.distance_to(center) < radius - e.radius:
			t.append(e)
	return t

func get_first_enemy_within(center, radius):
	var t = get_all_enemies_within(center, radius)
	var m = 0
	var r 
	for e in t:
		if e.offset > m:
			m = e.offset
			r = e
	return r









