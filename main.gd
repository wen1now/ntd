extends Node2D

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemy_scene
var ion_scene
var enemies
var tower_dict

# Called when the node enters the scene tree for the first time.
func _ready():
	#setting up enemies
	enemy_scene = load("res://enemy.tscn")
	enemies = []
	
	#setting up towers
	ion_scene = load("res://ion.tscn")
	tower_dict = {"ion": ion_scene}
	
	#initialising the game, will edit later
	new_enemy()
	new_tower("ion",Vector2(64*6+32,64*5+32))

func _process(delta):
	# get_all_enemies_within(Vector2(300,100),100)
	pass

func new_tower(type,pos):
	var tower
	tower = tower_dict[type].instance()
	tower.position = pos
	$towers.add_child(tower)

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

func get_first_enemy_within(center, radius, orthogonal = false):
	var t = get_all_enemies_within(center, radius)
	var m = 0
	var r
	if orthogonal:
		t = orthogonalize(center, t)
	for e in t:
		if e.offset > m:
			m = e.offset
			r = e
	return r

func target(tower):
	var r
	var target = tower.TARGET if tower.TARGET != null else "FIRST"
	if target == "FIRST":
		r = get_first_enemy_within(tower.position, tower.RANGE, tower.orthogonal)
		return r

func orthogonalize(center, enemy_list):
	var r = []
	for e in enemy_list:
		if almost_orthogonal(e.position - center):
			r.append(e)
	return r 

func almost_orthogonal(vect):
	var LEEWAY = 0.01
	return fposmod(vect.angle(),PI/2) < LEEWAY

# input: Vector2, Vector2, float
#        Width is the width (in pixels) of the beam
# output: array of arrays of (distance, enemy) near the ray, in order,
#         from closest to furthest to the point.
func get_enemies_in_line(point, ray, width=10):
	var t = []
	var relative_position
	var d1
	var d2
	ray = ray.normalized()
	width = width / 2.0
	for e in enemies:
		relative_position = e.position - point
		d1 = abs(relative_position.cross(ray))
		if d1 > width:
			continue
		d2 = relative_position.dot(ray)
		t.append([d2,e])
	t.sort_custom(self, "compare_array")
	return t

func compare_array(a, b):
	var i = 0
	while i < len(a) and i < len(b) and a[i] == b[i]:
		i += 1
	if i == len(a):
		return true
	if i == len(b):
		return false
	return a[i] < b[i]





