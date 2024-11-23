extends Node2D

func split():
	print("BANANA")
	var scene = load("res://player.tscn")
	var player1 = scene.instantiate()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_split"):
		split()
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
