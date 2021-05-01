extends KinematicBody2D

export var Acceleration = 300
export var Friction = 200
export var Max_Speed = 50

const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var hurtBox = $HurtBox
onready var playerDetector = $PlayerDetectionZone
onready var softCollision = $SoftCollision
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var wanderer = $Wanderer

enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO
var state = WANDER
var velocity = Vector2.ZERO

func _ready():
	print(stats.max_health)
	print(stats.health)

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, Friction * delta)
	knockback = move_and_slide(knockback)
	var player = playerDetector.player
	if player != null:
		state = CHASE
	else:
		pick_random_state([IDLE, WANDER])

	match state:
		CHASE:
			if player:
				accelerate_toward_point(player.global_position, delta)
				pick_random_state([IDLE, WANDER])

		IDLE:
			accelerate_toward_point(Vector2.ZERO, Friction * delta)

		WANDER:
			accelerate_toward_point(wanderer.target_position, delta)

	if softCollision.is_colliding():
		velocity += softCollision.get_push_vector() * delta * 400

	sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)

func accelerate_toward_point(point, delta):
	var direction = global_position.direction_to(point)
	velocity = velocity.move_toward(direction * Max_Speed, Acceleration * delta)

func pick_random_state(state_list):
	if (wanderer.get_time_left() == 0) or (global_position.distance_to(wanderer.target_position) <= 4):
		state_list.shuffle()
		state = state_list.pop_front()
		wanderer.set_timer(rand_range(1, 3))

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 100
	hurtBox.create_hit_effect()


func _on_Stats_no_health():
	queue_free()
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
