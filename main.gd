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

func target(tower):
	var r
	var target = tower.TARGET if tower.TARGET != null else "FIRST"
	if target == "FIRST":
		r = get_first_enemy_within(tower.position, tower.RANGE)
		if tower.orthogonal:
			r = orthogonalize(tower.position, r)
		return r

func orthogonalize(center, enemy_list):
	var r = []
	for e in enemy_list:
		if almost_orthogonal(e.position - center):
			r.append(e)
	return r 

func almost_orthogonal(vect):
	var LEEWAY = 0.01
	return fmod(abs(vect.angle())+LEEWAY/2,PI/2) < LEEWAY

# input: Vector2, Vector2, float
# output: array of enemies near the ray, in order, from closest to furthest
#         to the point. Width is the width (in pixels) of the beam
func get_enemies_in_line(point, ray, width=10):
	var t = []
	var relative_position
	var d1
	var d2
	ray = ray.normalized()
	width = width / 2.0
	for e in enemies:
		relative_position = e.position - point
		d1 = relative_position.cross(ray)
		if d1 > width:
			continue
		d2 = relative_position.dot(ray)
		t.append([d2,e])
	t.sort()
	return t
		








