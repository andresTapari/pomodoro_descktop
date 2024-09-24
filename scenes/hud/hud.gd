class_name HUD extends CanvasLayer

signal player_interaction(data)

var current_state : bool = false


const TOTAL_DURATION = 45 * 60	# Duración total en segundos (45 minutos)

var start_time			: int = 0			# Tiempo inicial en segundos desde el inicio del día
var time_left 			: int = 0			# Tiempo restante en segundos
var paused_time			: int = 0			# Tiempo transcurrido en pausa
var pause_start_time	: int = 0			# Momento en que se pausa el timer

# Se ejecuta al inicio de la escena
func _ready():
	# Guardar el tiempo de inicio al momento de comenzar el contador
	start_time = Time.get_unix_time_from_system()
	# Inicializar el tiempo restante
	time_left = TOTAL_DURATION
	# Actualizar el label inicialmente
	update_timer_display()
	# Al iniciar el timer comienza en pausa
	$Timer.paused = true

# Función para actualizar la interfaz con el tiempo restante
func update_timer_display():
	var minutes = time_left / 60
	var seconds = time_left % 60
	%Label.text = "%02d:%02d" % [minutes, seconds]
	

## Se ejecuta cuando se presiona el boton de play
func _on_button_play_toggled(toggled_on: bool) -> void:
	current_state = toggled_on
	$Timer.paused = !toggled_on
	%ButtonPlay.text="PLAY" if !toggled_on else "PAUSA"
	player_interaction.emit({'cmd':"play" if toggled_on else "pausa"})
	if toggled_on:
		# Si se reanuda el Timer, calcula el tiempo que ha estado en pausa
		paused_time += Time.get_unix_time_from_system() - pause_start_time
	else:
		# Si se pausa el Timer, guarda el momento en que se pausa
		pause_start_time = Time.get_unix_time_from_system()

func _on_timer_timeout() -> void:
		# Calcular el tiempo transcurrido en segundos desde el inicio
	var elapsed_time = Time.get_unix_time_from_system() - start_time - paused_time

	# Calcular el tiempo restante
	time_left = TOTAL_DURATION - elapsed_time

	# Actualizar el contador en pantalla
	update_timer_display()

	# Detener el Timer si se llega a cero
	if time_left <= 0:
		$Timer.stop()
		time_left = 0
		update_timer_display()
