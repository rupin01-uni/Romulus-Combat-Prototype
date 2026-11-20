extends CharacterBody2D

@export var speed: float = 200.0

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var sword_collision: CollisionShape2D = $SwordHitbox/CollisionShape2D
@onready var sword_hitbox: Area2D = $SwordHitbox

var facing_direction: String = "down"
var is_attacking: bool = false
var combo_step: int = 0
var combo_broken: bool = false
var successful_chain: bool = false
var already_hit: bool = false
var combo_window: float = 0.2
var combo_timer: float = 0.0
var recovery_timer: float = 0.0
var recovery_duration: float = 0.0
var hitstop_duration: float = 0.11
var hitstop_active: bool = false


func _ready():
	sprite.animation_finished.connect(_on_animation_finished)
	var animation_name = "reverse_" + facing_direction
	var frame_count = sprite.sprite_frames.get_frame_count(animation_name)
	var animation_speed = sprite.sprite_frames.get_animation_speed(animation_name)
	recovery_duration = float(frame_count) / animation_speed



func _physics_process(delta):
	
	if recovery_timer > 0:
		recovery_timer = max(recovery_timer - delta, 0.0)

	if combo_timer > 0:
		combo_timer -= delta
		if combo_timer <= 0:
			combo_timer = 0
			combo_step = 0
	
	
	if is_attacking:
		velocity = Vector2.ZERO
		update_attack_window()
		
		var last_frame = sprite.sprite_frames.get_frame_count(sprite.animation) - 1
		
		if Input.is_action_just_pressed("attack_light"):
			if sprite.frame == last_frame and not combo_broken:
				combo_step += 1
				successful_chain = true
				already_hit = false
				update_sword_hitbox()
				if combo_step % 2 == 1:
					sprite.play("reverse_" + facing_direction)
				else:
					sprite.play("halfslash_" + facing_direction)
			else:
				combo_step = 0
				combo_broken = true

		return


	var direction = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	
	if Input.is_action_just_pressed("attack_light") and recovery_timer <= 0.0:
		is_attacking = true
		successful_chain = false
		combo_broken = false
		already_hit = false
		update_sword_hitbox()
		
		
		if combo_timer > 0 and combo_step % 2 == 1:
			sprite.play("reverse_" + facing_direction)
		else:
			sprite.play("halfslash_" + facing_direction)
			
		update_attack_window()
		combo_timer = 0
		return
	
	velocity = direction * speed
	move_and_slide()
	
	if direction.length() > 0.2:
		if abs(direction.x) > abs(direction.y):
			if direction.x > 0:
				facing_direction = "right"
			else:
				facing_direction = "left"
		else:
			if direction.y > 0:
				facing_direction = "down"
			else:
				facing_direction = "up"
	if direction != Vector2.ZERO:
		sprite.play("walk_" + facing_direction)
	else:
		sprite.play("idle_" + facing_direction)

func _on_animation_finished():
	if is_attacking:
		is_attacking = false
		
		if successful_chain:
			recovery_timer = 0.0
		else:
			recovery_timer = recovery_duration

		sword_collision.set_deferred("disabled", true)
		combo_step = 0
		combo_timer = 0
		sprite.play("idle_" + facing_direction)


func _on_sword_hitbox_body_entered(body: Node2D) -> void:
	if body == self:
		return
		
	if already_hit:
		return
	
	already_hit = true
	var damage = 10

	if combo_step % 2 == 1:
		damage = 18

	if body.has_method("take_damage"):
		body.take_damage(damage)
		apply_hitstop()
	
func update_sword_hitbox():
	match facing_direction:
		"up":
			sword_hitbox.position = Vector2(0, -30)
			sword_collision.rotation_degrees = 0
		"down":
			sword_hitbox.position = Vector2(0, 30)
			sword_collision.rotation_degrees = 0
		"left":
			sword_hitbox.position = Vector2(-30, 0)
			sword_collision.rotation_degrees = 90
		"right":
			sword_hitbox.position = Vector2(30, 0)
			sword_collision.rotation_degrees = 90


func update_attack_window():
	if not is_attacking:
		sword_collision.set_deferred("disabled", true)
		return

	var active_hit = false

	if sprite.animation.begins_with("halfslash_"):
		active_hit = sprite.frame == 4
	elif sprite.animation.begins_with("reverse_"):
		active_hit = sprite.frame == 2

	sword_collision.set_deferred("disabled", not active_hit)



func apply_hitstop() -> void:
	if hitstop_active:
		return

	hitstop_active = true
	var original_speed = sprite.speed_scale
	sprite.speed_scale = 0.0

	await get_tree().create_timer(hitstop_duration).timeout

	sprite.speed_scale = original_speed
	hitstop_active = false
