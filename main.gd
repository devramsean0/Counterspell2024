extends Node2D

@export var health = 10

var current_scene: Node2D
var previous_scene: Node2D

@onready var current_viewport = $CurrentLevel
@onready var previous_viewport = $PreviousLevel

func free_previous():
	if previous_scene:
		previous_scene.queue_free()
		previous_scene = null

func rotate_scenes():
	free_previous()
	
	if current_scene:
		previous_scene = current_scene
		previous_scene.won.disconnect(current_won)
		previous_scene.won.connect(die)
		current_viewport.remove_child(previous_scene)
		previous_viewport.add_child(previous_scene)

func new_scene(scene: Resource):
	var object = scene.instantiate()
	current_scene = object
	current_scene.died.connect(die)
	current_scene.won.connect(current_won)
	current_viewport.add_child(current_scene)

func current_won():
	print("yay i win")
	rotate_scenes()
	new_scene(previous_scene.next)
	
func die():
	print("fuck ow i died")
	rotate_scenes()
	free_previous()
	_ready()
	
func _input(event: InputEvent):
	if event.is_action("ui_split"):
		current_scene.split()

func _ready() -> void:
	var intro_level_scene = preload("res://levels/intro.tscn")
	new_scene(intro_level_scene)
