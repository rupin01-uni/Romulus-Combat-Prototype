extends StaticBody2D

@onready var visual: Polygon2D = $Polygon2D


@export var max_health: int = 100
var health: int = 100


func take_damage(amount: int):
	var actual_damage = min(amount, health)
	health = max(health - amount, 0)
	if actual_damage > 0:
		flash_red()

	print("Damage dealt: ", actual_damage)
	print("Dummy health: ", health, " / ", max_health)
	print("----------------")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass



func flash_red() -> void:
	visual.color = Color.RED
	await get_tree().create_timer(0.08).timeout
	visual.color = Color(0.55, 0.27, 0.07)
