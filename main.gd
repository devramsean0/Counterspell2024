extends Node2D

@export var health = 10

var current_scene: Node2D
var previous_scene: Node2D

func free_previous():
	if previous_scene:
		previous_scene.queue_free()
		previous_scene = null

func rotate_scenes():
	if current_scene:
		previous_scene = current_scene
		previous_scene.won.disconnect(current_won)
		previous_scene.won.connect(die)
		remove_child(previous_scene)
		$CanvasGroup.add_child(previous_scene)

func new_scene(scene: Resource):
	var object = scene.instantiate()
	current_scene = object
	current_scene.died.connect(die)
	current_scene.won.connect(current_won)
	add_child(current_scene)

func current_won():
	rotate_scenes()
	new_scene(previous_scene.next)
	
func die():
	print("todo!")
	rotate_scenes()
	free_previous()
	_ready()

func _ready() -> void:
	var intro_level_scene = preload("res://levels/intro.tscn")
	new_scene(intro_level_scene)
