extends Camera2D

@export var camera_speed : int = 200

var current_speed = 0
func _ready() -> void:
	var hud = get_tree().get_first_node_in_group("hud") as HUD
	hud.player_interaction.connect(_handle_player_interaction)

func _process(delta: float) -> void:
	# Movemos la camara
	position.x += delta*current_speed

func _handle_player_interaction(data) -> void:
	if data["cmd"] == "play":
		current_speed = camera_speed
	else:
		current_speed = 0
