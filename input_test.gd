extends Node3D

@export var start_focus_buttons: Array[Button]

var wasd_dict: Dictionary = {
	"ui_up": KEY_W,
	"ui_left": KEY_A,
	"ui_down": KEY_S,
	"ui_right": KEY_D,
}

var tfgh_dict: Dictionary = {
	"ui_up": KEY_T,
	"ui_left": KEY_F,
	"ui_down": KEY_G,
	"ui_right": KEY_H,
}

var ijkl_dict: Dictionary = {
	"ui_up": KEY_I,
	"ui_left": KEY_J,
	"ui_down": KEY_K,
	"ui_right": KEY_L,
}

func _ready() -> void:
	print("Max Players: %s" % Input.PLAYERS_MAX)
	for i in start_focus_buttons.size():
		start_focus_buttons[i].call_thread_safe("grab_focus", i)
		pass

func _process(delta: float) -> void:
	pass

func _unhandled_key_input(event: InputEvent):
	if event is InputEventKey:
		manage_multiplayer_arrow_keys(event, wasd_dict, PLAYER_ID_P2)
		manage_multiplayer_arrow_keys(event, tfgh_dict, PLAYER_ID_P3)
		manage_multiplayer_arrow_keys(event, ijkl_dict, PLAYER_ID_P4)
	else:
		print(event)

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		return
	elif event is InputEventJoypadMotion:
		return
	
	print("Device %s; Player %s; %s" % [event.device, event.player, event])

func manage_multiplayer_arrow_keys(event: InputEventKey, keys_dict: Dictionary, player: int) -> void:
	for key in keys_dict:
		if event.player == PLAYER_ID_P1 && event.keycode == keys_dict[key] && event.is_pressed():
			get_viewport().set_input_as_handled()
			var key_event = InputEventAction.new()
			key_event.player = player
			key_event.action = key
			key_event.pressed = true
			Input.parse_input_event(key_event)
