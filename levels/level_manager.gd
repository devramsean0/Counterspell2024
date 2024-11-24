class_name Level
extends Node2D

@export var prev: Resource = preload("res://levels/level_manager.tscn")
@export var next: Resource = preload("res://levels/level_manager.tscn")

var player = preload("res://player.tscn")
var can_split = true

signal died
signal won


func on_player_collision(player: Player, collision: Node2D):
	print(collision.name)
	
	if collision == $DamageTilemap:
		# kill the player
		died.emit()
	elif collision == $WinTilemap:
		# win
		remove_child(player)
		won.emit()

func split():
	if not can_split:
		return
	
	var current_player: Node2D = $Player
	var pos = current_player.position
	self.remove_child(current_player)
	var player1 = player.instantiate()
	var player2 = player.instantiate()
	player1.collided.connect(on_player_collision)
	player2.collided.connect(on_player_collision)
	player1.position = pos
	player1.position.x -= - 8
	player2.position = pos
	player2.position.x -= + 8
	player1.scale = current_player.scale * Vector2(0.5, 0.5)
	player2.scale = current_player.scale * Vector2(0.5, 0.5)
	self.add_child(player1)
	self.add_child(player2)
	
	can_split = false

func _ready() -> void:
	$Player.collided.connect(on_player_collision)
