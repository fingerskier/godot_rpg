extends KinematicBody2D

export var Acceleration = 300
export var Friction = 200
export var Max_Speed = 50

const DeathEffect = preload("res://Effects/EnemyDeathEffect.tscn")

onready var playerDetector = $PlayerDetectionZone
onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var hurtBox = $HurtBox

enum {
	IDLE,
	WANDER,
	CHASE
}

var knockback = Vector2.ZERO
var state = CHASE
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
		state = IDLE

	match state:
		CHASE:
			var direction = (player.global_position - global_position).normalized()
			velocity = velocity.move_toward(direction * Max_Speed, Acceleration * delta)

		IDLE:
			velocity = velocity.move_toward(Vector2.ZERO, Friction * delta)

		WANDER:
			pass

	sprite.flip_h = velocity.x < 0
	velocity = move_and_slide(velocity)

func seek_player():
	if playerDetector.can_see_player():
		state = CHASE

func _on_HurtBox_area_entered(area):
	stats.health -= area.damage
	knockback = area.knockback_vector * 100
	hurtBox.create_hit_effect()


func _on_Stats_no_health():
	queue_free()
	var deathEffect = DeathEffect.instance()
	get_parent().add_child(deathEffect)
	deathEffect.global_position = global_position
