extends Node3D

@export var start_focus_buttons: Array[Button]

func _ready() -> void:
	for i in start_focus_buttons.size():
		start_focus_buttons[i].call_thread_safe("grab_focus", i)
		pass

func _process(delta: float) -> void:
	pass

func _unhandled_key_input(event: InputEvent):
	if event is InputEventKey:
		# print("Device: %s; Player: %s;" % [event.device, event.get_player()])
		manage_ijkl(event)
	else:
		print(event)

func _input(event: InputEvent):
	if event.player == Input.PLAYER_2:
		print("Player 2 Input.")
		pass
	elif event is InputEventAction:
		print(event)
		pass

func manage_ijkl(event: InputEventKey) -> void:
	var ijkl_dict: Dictionary = {
		"ui_up": KEY_I,
		"ui_left": KEY_J,
		"ui_down": KEY_K,
		"ui_right": KEY_L,
	}
	for key in ijkl_dict:
		if event.player != Input.PLAYER_2 && event.keycode == ijkl_dict[key] && event.is_pressed():
			get_viewport().set_input_as_handled()
			var p2_event = InputEventAction.new()
			p2_event.player = Input.PLAYER_2
			p2_event.action = key
			p2_event.pressed = true
			Input.parse_input_event(p2_event)
