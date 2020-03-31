extends Sprite

var TARGET = "FIRST"
var RANGE = 200
var BULLET_RANGE = 300
var RELOAD = 2

var orthogonal = true


func _ready():
	$Timer.time_left = RELOAD

func can_shoot():
	return $Timer.timeout()

func shoot():
	var target = get_parent().target(self)
	if target == null:
		return
	$Timer.start(RELOAD)
	turn_to((target.position - position).angle())
	var targets = get_parent().get_enemies_in_line(position, target.position - position)
	var distance
	var enemy
	for i in targets:
		distance = targets[i][0]
		enemy = targets[i][1]
		if distance < BULLET_RANGE:
			enemy.health -= 1

func turn_to(angle):
	pass
