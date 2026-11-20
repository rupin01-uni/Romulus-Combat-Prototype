extends StaticBody2D

@export var max_health: int = 100
var health: int = 100


func take_damage(amount: int):
	var actual_damage = min(amount, health)
	health = max(health - amount, 0)

	print("Damage dealt: ", actual_damage)
	print("Dummy health: ", health, " / ", max_health)
	print("----------------")



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
