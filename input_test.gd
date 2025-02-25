extends Node3D

@onready var start_focus_buttons : Array[Control] = [
	$CanvasLayer/MarginContainer/GridContainer/PlayerControl1/GridContainer/Button,
	$CanvasLayer/MarginContainer/GridContainer/PlayerControl2/GridContainer/Button,
	$CanvasLayer/MarginContainer/GridContainer/PlayerControl3/GridContainer/Button,
	$CanvasLayer/MarginContainer/GridContainer/PlayerControl4/GridContainer/Button
]

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
	# start_focus_buttons[0].grab_focus(PLAYER_ID_P1)
	print("Max Players: %s" % Input.PLAYERS_MAX)
	for i in start_focus_buttons.size():
		start_focus_buttons[i].call_thread_safe("grab_focus", i)
		pass
	
	if Input.is_joy_known(0):
		# Map joypad 0 to player 4.
		Input.set_joy_player_id(0, PLAYER_ID_P4)
	
	ProjectSettings.set_setting("input/keyboard_player_id_override", PLAYER_ID_P2)
	ProjectSettings.set_setting("input/mouse_player_id_override", PLAYER_ID_P2)
	ProjectSettings.set_setting("input/touch_player_id_override", PLAYER_ID_P2)

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("ui_select", false, PLAYER_ID_P1):
		for i in start_focus_buttons.size():
			print(start_focus_buttons[i].get_focused_players_id())

func _input(event: InputEvent):
	if event is InputEventMouseMotion:
		return
	elif event is InputEventJoypadMotion:
		return
	elif event is InputEventKey:
		manage_multiplayer_arrow_keys(event, wasd_dict, PLAYER_ID_P2)
		manage_multiplayer_arrow_keys(event, tfgh_dict, PLAYER_ID_P3)
		manage_multiplayer_arrow_keys(event, ijkl_dict, PLAYER_ID_P4)
	
	print("Device %s; Player %s; %s" % [event.device, event.player, event])

func manage_multiplayer_arrow_keys(event: InputEventKey, keys_dict: Dictionary, player: int) -> void:
	for key in keys_dict:
		if event.keycode == keys_dict[key] && event.is_pressed():
			get_viewport().set_input_as_handled()
			var key_event = InputEventAction.new()
			key_event.player = player
			key_event.action = key
			key_event.pressed = true
			Input.parse_input_event(key_event)
