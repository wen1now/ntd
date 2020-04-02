extends Sprite

var TARGET = "FIRST"
var RANGE = 200
var BULLET_RANGE = 300
var RELOAD = 0.1
var can_shoot = false

var orthogonal = true


func _ready():
	$Timer.wait_time = RELOAD

#func can_shoot():
#	return $Timer.timeout()

func _on_Timer_timeout():
	can_shoot = true

func shoot():
	var target = get_parent().get_parent().target(self)
	if target == null:
		return
	$Timer.start(RELOAD)
	turn_to((target.position - position).angle())
	var targets = get_parent().get_parent().get_enemies_in_line(position, target.position - position)
	var distance
	var enemy
	for i in targets:
		distance = i[0]
		enemy = i[1]
		if distance < BULLET_RANGE:
			enemy.health -= 1
	can_shoot = false

func _process(delta):
	if can_shoot:
		shoot()
		$Timer.start()
	


func turn_to(angle):
	pass



