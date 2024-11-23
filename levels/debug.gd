extends Node2D

@export var health = 10
var has_split = false

func split():
	has_split = true
	var current_player: Node2D = $Player
	var pos = current_player.position
	self.remove_child(current_player)
	var scene = preload("res://player.tscn")
	var player1 = scene.instantiate()
	var player2 = scene.instantiate()
	player1.position = pos
	player1.position.x -= - 8
	player2.position = pos
	player2.position.x -= + 8
	player1.scale = current_player.scale * Vector2(0.5, 0.5)
	player2.scale = current_player.scale * Vector2(0.5, 0.5)
	self.add_child(player1)
	self.add_child(player2)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_split") and not has_split:
		split()

func _ready() -> void:
	var intro_level_scene = preload("res://levels/intro.tscn")
	var intro = intro_level_scene.instantiate()
	add_child(intro)
