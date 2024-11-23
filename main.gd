extends Node2D

@export var health = 10

var current_scene: Node2D
var previous_scene: Node2D

func current_won():
	if previous_scene:
		previous_scene.queue_free()
		previous_scene = null
	
	previous_scene = current_scene
	previous_scene.z_index = 10000
	previous_scene.won.disconnect(current_won)
	previous_scene.won.connect(die)
	previous_scene.scale = Vector2(0.2, 0.2)
	
	current_scene = previous_scene.next.instantiate()
	current_scene.died.connect(die)
	current_scene.won.connect(current_won)
	add_child(current_scene)
	
func die():
	print("todo!")
	if previous_scene:
		previous_scene.queue_free()
		previous_scene = null
	current_scene.queue_free()
	_ready()
	

func _ready() -> void:
	var intro_level_scene = preload("res://levels/intro.tscn")
	var intro = intro_level_scene.instantiate()
	current_scene = intro
	current_scene.died.connect(die)
	current_scene.won.connect(current_won)
	add_child(intro)
