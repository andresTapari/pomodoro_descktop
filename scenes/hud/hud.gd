class_name HUD extends CanvasLayer

signal player_interaction(data)

## Se ejecuta cuando se presiona el boton de play
func _on_button_play_toggled(toggled_on: bool) -> void:
	%ButtonPlay.text="PLAY" if !toggled_on else "PAUSA"
	player_interaction.emit({'cmd':"play" if toggled_on else "pausa"})
